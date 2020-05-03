import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "videoIframe" ]

  connect() {
    let videoModalController = this;
    $(this.element).on('show.bs.modal', (event) => {
      videoModalController.setupVideo();
    })

    $(this.element).on('hide.bs.modal', (event) => {
      videoModalController.shutdownVideo();
    })
  }

  setupVideo(){
    this.videoIframeTarget.src = this.videoIframeTarget.dataset.src;
  }

  shutdownVideo(){
    this.videoIframeTarget.src = 'about:blank';
  }
}
