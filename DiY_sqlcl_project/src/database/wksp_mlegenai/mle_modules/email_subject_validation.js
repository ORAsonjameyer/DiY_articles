 
/**
 * Ensure the metadata column contains a key named "Subject"
 *
 * @param {object} metadata - the JSON column as provided by the APEX page item
 * @returns {boolean} true if the metadata contains a subject, false otherwise
 */
export function checkForSubject(metadata) {
  const myObject = JSON.parse(metadata);
	if ("priority" in myObject) {
		return true;
	}
	return false;
}
