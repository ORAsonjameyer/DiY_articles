
  CREATE OR REPLACE MLE MODULE "WKSP_MLEGENAI"."EMAIL_SUBJECT_VALIDATION" 
   LANGUAGE JAVASCRIPT AS 
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
/


-- sqlcl_snapshot {"hash":"9a58a6d7ed21f5c9d957466fd748fecedf1bf214","type":"MLE_MODULE","name":"EMAIL_SUBJECT_VALIDATION","schemaName":"WKSP_MLEGENAI","sxml":""}