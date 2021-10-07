function handleKeyPresses(event) {
    let key = event.keyCode || event.which;
    if (key === 13) {
        const input = document.getElementById("input-prompt");
        handleSearch(input.value);

        input.value = "";
    }
}

function handleSearch(url) {
    let uri = `https://duckduckgo.com/?q=` + url;
    
    window.open(uri, "_blank");
}

document.addEventListener("keydown", handleKeyPresses);
