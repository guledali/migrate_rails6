document.addEventListener("turbolinks:load", () => {
    const element = document.getElementById('nav-tab');
    const text = document.querySelector('.text');
    const imageVideo = document.querySelector('.image_video');
    const url = document.querySelector('.url');

    if(imageVideo !== null || url !== null) {
        imageVideo.classList.add('hidden');
        url.classList.add('hidden');
    }
    function onTabClick (event) {
        const activeTabs = document.querySelectorAll('.active');
        activeTabs.forEach(function(tab) {
            tab.classList.toggle('active'); 
        });
        event.target.parentElement.classList.add('active');
        event.preventDefault()
    }

    function determineType(event) {
        const types = {
            text: "text",
            image_video: "image_video",
            url: "url"
        };
        // Text
        if (event.target.parentElement.dataset.tab == types.text) {
            text.classList.remove('hidden');
            imageVideo.classList.add('hidden');
            url.classList.add('hidden');

            url.querySelector('input[type="text"]').value = "";
        }
        // Image / Video
        if (event.target.parentElement.dataset.tab == types.image_video) {
            imageVideo.classList.remove('hidden');
            text.classList.add('hidden');
            url.classList.add('hidden');
    
            text.querySelector("textarea").value = "";
            url.querySelector("input[type=text]").value = "";
        }
    
        // URL
        if (event.target.parentElement.dataset.tab == types.url) {
            url.classList.remove('hidden');
            text.classList.add('hidden');
            imageVideo.classList.add('hidden');
    
            text.querySelector("textarea").value = "";
        }      
    }

    if (element !== null) {
        element.addEventListener('click', function(event) {
            onTabClick(event);
            determineType(event);
        })
    }
});