import { Controller } from 'stimulus'

export default class extends Controller {

  showDescription(event) {
    event.preventDefault();
    fetch(`/api/v1/videos/${event.target.id}`)
      .then((response) => response.json())
      .then(function(response){
        const desc = document.querySelector(`#description-${event.target.id}`);
        desc.innerHTML = response.description
      });
  }

bookmarkVideo(event) {
  event.preventDefault();
   fetch(`/api/v1/bookmarks`, {
     method: 'POST',
     body: JSON.stringify({"user_id": event.target.getAttribute("user_id"), "video_id": event.target.getAttribute("video_id")}),
     headers: {
       'Content-Type': 'application/json',
       'X-CSRF-Token': Rails.csrfToken ()
     },
     credentials: 'same-origin'
   }).then(function(response) {
     return response.json();
   }).then(function(data) {
     console.log(data);
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
