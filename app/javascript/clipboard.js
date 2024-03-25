document.addEventListener('turbolinks:load', function() {
	const copyButton = document.getElementById('copyButton');
	if (copyButton) {
			copyButton.addEventListener('click', function(event) {
					const sourceValue = event.currentTarget.getAttribute('data-clipboard-source-value');
					navigator.clipboard.writeText(sourceValue)
							.then(() => console.log('Copying to clipboard was successful!'))
							.catch(err => console.error('Could not copy text: ', err));
			});
	}
});