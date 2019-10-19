import { Controller } from 'stimulus'

export default class extends Controller {

static targets = [ "user_id", "video_id" ]

  bookmarkVideo = event => {
  event.preventDefault();
  const videoId = event.target.getAttribute("video_id")
  const userId = event.target.getAttribute("user_id")
  	fetch("/api/v1/bookmarks", {
  		method: "POST",
  		headers: {
  		  "Content-Type": "application/json; charset=utf-8",
  		},
  		body: JSON.stringify({"user_id":event.target.getAttribute("user_id"), "video_id":event.target.getAttribute("video_id")})
  		})
  		.then(response => response.json())
  		.then (data => data)
  		.catch(error => console.error(error))
  		alert("Bookmark added to your dashboard!");
  		}

  showDescription(event) {
    event.preventDefault();
    fetch(`/api/v1/videos/${event.target.id}`)
      .then((response) => response.json())
      .then(function(response){
        const desc = document.querySelector(`#description-${event.target.id}`);
        desc.innerHTML = response.description
      });
  }
  
  showVideoForm(event) {
    event.preventDefault();

    var elem = document.getElementById("new-video-form");
    var getHeight = function () {
      elem.style.display = 'block';
      var height = elem.scrollHeight + 'px';
      elem.style.display = '';
      return height;
    };

    var height = getHeight();
    elem.classList.add('is-visible');
    elem.style.height = height;

    window.setTimeout(function () {
      elem.style.height = '';
    }, 350);
  }

  updateOrder(event) {
    event.preventDefault();
    fetch(`/admin/api/v1/tutorial_sequencer/${event.target.id}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: JSON.stringify(sortable.toArray())
    })
      .then((response) => response.json())
      .then(function(response){
        console.log("hello");
      });
  }

}
