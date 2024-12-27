import { useState, useEffect } from 'react'
import { fetchNui } from '../utils/fetchNui'
import './SpawnSelect.css'

function SpawnSelect() {
    const [visible, setVisible] = useState(false)
    const [spawnPoints, setSpawnPoints] = useState([])
    const [selectedPoint, setSelectedPoint] = useState(null)

    useEffect(() => {
        const handleMessage = (event) => {
            const data = event.data
            
            if (data.type === 'ui') {
                setVisible(data.status)
            } else if (data.type === 'setSpawnPoints') {
                setSpawnPoints(Array.isArray(data.points) ? data.points : [])
            }
        }

        window.addEventListener('message', handleMessage)
        return () => window.removeEventListener('message', handleMessage)
    }, [])

    const handleSpawnSelect = async (point) => {
        setSelectedPoint(point)
    }

    const handleSpawnConfirm = async () => {
        if (selectedPoint) {
            try {
                // console.log("trying to spawn at location: " + selectedPoint.coords.x + ", " + selectedPoint.coords.y + ", " + selectedPoint.coords.z)
                await fetchNui('spawnAtLocation', {
                    coords: {
                        x: selectedPoint.coords.x,
                        y: selectedPoint.coords.y,
                        z: selectedPoint.coords.z,
                        heading: selectedPoint.coords.heading || 0.0
                    }
                })
            } catch (error) {
                console.error('Error spawning at location:', error)
            }
        }
    }

    if (!visible) return null

    return (
        <div className="spawn-select">
            <h1 className="spawn-title">Select Spawn Location</h1>
            <div className="spawn-points">
                {spawnPoints.length === 0 ? (
                    <p>Loading spawn points...</p>
                ) : (
                    spawnPoints.map((point, index) => (
                        <div 
                            key={index}
                            className={`spawn-point ${selectedPoint === point ? 'selected' : ''}`}
                            onClick={() => handleSpawnSelect(point)}
                        >
                            {point.image && (
                                <img src={point.image} alt={point.name} />
                            )}
                            <h3>{point.name}</h3>
                            <p>{point.description}</p>
                        </div>
                    ))
                )}
            </div>
            
            <button 
                className="spawn-button"
                onClick={handleSpawnConfirm}
                disabled={!selectedPoint}
            >
                {selectedPoint 
                    ? `Spawn at ${selectedPoint.name}` 
                    : 'Select a location to spawn'}
            </button>
        </div>
    )
}

export default SpawnSelect