var errCodes = {}

function setErrorCode(name, code, msg){
	errCodes[name] = {code: code, message: msg}
}

setErrorCode('NO_ANON_SESSION',      105, 'Connected without session')
setErrorCode('BAD_ANON_FINGERPRINT', 110, 'Bad anonimous fingerprint')
setErrorCode('ANON_IS_BLOCKED',      115, 'Anonimous client acts too often')
setErrorCode('NO_USER_SESSION',      120, 'User session is absent')
setErrorCode('BAD_USER_FINGERPRINT', 125, 'Bad users fingerprint')
setErrorCode('USER_IS_BLOCKED',      130, 'User acts too often')
setErrorCode('KEY_ALREADY_EXISTS',   135, 'Key already exists in RedisDB')
setErrorCode('WRONG_VALUE_AT_KEY',   140, 'Wrong value at key')
setErrorCode('EMPTY_SESSION',        145, 'Empty session')
setErrorCode('BAD_CREDENTIALS',      150, 'Bad credentials')
setErrorCode('BAD_REQUEST_PARAM',    155, 'Bad request param')
setErrorCode('BAD_INVITE',           160, 'No invite or bad invite')
setErrorCode('USER_IS_BANNED',       165, 'User is banned')
setErrorCode('EMPTY_ARRAY_OF_KEYS',  170, 'Empty array of KEYS')
setErrorCode('EMPTY_ARRAY_OF_CSV',   175, 'Empty array of CSV')
setErrorCode('EMPTY_ARRAY_OF_CSV',   180, 'No such host')
setErrorCode('NO_SUCH_KEY',          185, 'No such key')

module.exports = errCodes
