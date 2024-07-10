(function() {
    const API_KEY = '72Q4N3ZBWD3A8K69EQ6G726XF';
    const URL_TEMPLATE = `https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Shanghai?unitGroup=metric&key=${API_KEY}&contentType=json`;
    window.onload = function() {
        fetch(URL_TEMPLATE).then(response => response.json()).then(data => {
            console.log(data);
            const {resolvedAddress, currentConditions} = data;
            const { temp: currentTemp } = currentConditions;
            const viewPort = document.getElementById('weather');
            const summary = document.createElement('DIV');
            summary.innerHTML = `${resolvedAddress}: ${currentTemp}&deg;C, ${currentConditions.conditions}`;
            viewPort.appendChild(summary);
        }).catch(error => {
            console.log(error)
        })
    };
})()