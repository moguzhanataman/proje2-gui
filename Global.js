var suspendTime = null
var previousTime = null
var lapStartTime = null

function zeroPad(n) {

    return (n < 10 ? "0" : "") + n

}

function toTime(usec) {

    var mod = Math.abs(usec)
    return (usec < 0 ? "-" : "") +
            (mod >= 3600000 ? Math.floor(mod / 3600000) + ':' : '') +
            zeroPad(Math.floor((mod % 3600000) / 60000)) + ':' +
            zeroPad(Math.floor((mod % 60000) / 1000)) + '.' +
            Math.floor((mod % 1000) / 100)
}

function toDelta(msec) {

    var mod = Math.abs(msec)
    var hours = Math.floor(mod / 3600000)
    var minutes = Math.floor((mod % 3600000) / 60000)
    var seconds = Math.floor((mod % 60000) / 1000)
    var decimal = Math.floor((mod % 1000) / 100)

    var result = msec < 0 ? "-" : "+"
    if (hours > 0)
        result += hours + ":"
    if (minutes > 0)
        result += (hours > 0 ? zeroPad(minutes) : minutes) + ":"
    result += (minutes > 0 ? zeroPad(seconds) : seconds) + "." + decimal

    return result
}
