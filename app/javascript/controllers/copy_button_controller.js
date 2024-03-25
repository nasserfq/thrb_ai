import { Controller } from "stimulus"

export default class extends Controller {
	static targets = ["source"]

	copy(event) {
			event.preventDefault()
			// Use 'this.sourceTarget.value' to access the value of the input
			navigator.clipboard.writeText(this.sourceTarget.value)
					.then(() => console.log('Copying to clipboard was successful!'))
					.catch(err => console.error('Could not copy text: ', err));
	}
}