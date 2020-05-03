import { Controller } from "stimulus";
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "body" ];

  initialize () {
  }

  connect() {
    let projectsController = this;

    this.subscription = consumer.subscriptions.create({
      channel: "ProjectChannel",
      id: this.data.get("id")
    }, {
      received(data) {
        projectsController.renderPartial(data);
      }
    });
  }

  disconnect() {
    this.subscription.unsubscribe();
  }

  renderPartial(data) {
    let projectsController = this;
    let body = new DOMParser().parseFromString( data['body'] , 'text/html');

    let permanentNodes = this.bodyTarget.querySelectorAll("[id][data-turbolinks-permanent]");

    // Replace all data-turbolinks-permanent elements in the body
    permanentNodes.forEach(function(element){
      var oldElement = body.querySelector(`#${element.id}[data-turbolinks-permanent]`)
      oldElement.parentNode.replaceChild(element, oldElement);
    });

    this.element.replaceChild(body.querySelector('[data-target="projects.body"]'), this.bodyTarget);

    Chartkick.eachChart(function(chart) {
      chart.refreshData();
    });
  }
}
