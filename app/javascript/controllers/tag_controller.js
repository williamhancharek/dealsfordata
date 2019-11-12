// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["name", "output", "keyword", "tags"]

  initialize() {
    this.keywordTarget.value = ""
  }

  add() {
    event.preventDefault()
    var re = new RegExp('[A-Za-z]+')
    if (!!(this.nameTarget.value.match(re))) {
      this.outputTarget.innerHTML +=
      `<span class="badge badge-primary" data-action="tag.remove" data-target="tag.tags">
        ${this.nameTarget.value}</span>
        `
      this.keywordTarget.value += `${this.nameTarget.value} `
      this.nameTarget.value = ""
    }
  }

  reset() {
    event.preventDefault()
    this.outputTarget.innerHTML = ""
    this.keywordTarget.value = ""
  }
}
