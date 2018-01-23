function checkEntries() {
  var u = document.getElementById('puser').value;
  var p = document.getElementById('ppass').value;
  var used = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  var ok = false;
  if (u === 'cavs') {
    if (p > 0 && p.length == 10) {
      ok = true;
      for (i = 1; i <= 10; i++) {
        var digit = p.charAt(i - 1);
        var part = p.substring(0, i);
        if (used[digit] != 0 || part % i != 0) {
          ok = false
        }
        if (used[digit] == 0) {
          used[digit] = 1
        }
      }
    }
  }
  if (ok) {
    document.location.href = 'palm_' + u + '_' + p + '.html'
  } else {
    alert('nope')
  }
}
