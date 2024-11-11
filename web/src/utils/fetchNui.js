export async function fetchNui(eventName, data = {}) {
    const options = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify(data)
    };

    const resourceName = 'desync-spawnselect';

    try {
        const resp = await fetch(`https://${resourceName}/${eventName}`, options);
        return await resp.json();
    } catch (error) {
        if (process.env.NODE_ENV === 'development') {
            console.log(`Failed to fetch NUI callback ${eventName}:`, error);
            return { error: 'Development environment - NUI callback failed' };
        }
        return undefined;
    }
} 