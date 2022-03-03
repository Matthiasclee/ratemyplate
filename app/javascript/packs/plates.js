function addHrefToStorage(h){
  if (localStorage.hrefs == undefined) {
    localStorage.setItem("hrefs", h)
  }else{
    localStorage.hrefs = localStorage.hrefs + "," + h
  }

  disableUpvotedPlates()
  updatePlateScore(h)
}

window.addHrefToStorage = addHrefToStorage

function disableUpvotedPlates(){
  x = localStorage.hrefs.split(",")
  for (a in x){
    hrf = x[a]
    document.querySelectorAll(`a[href='${hrf}']`)[0].classList.add("upvoted")
    document.querySelectorAll(`a[href='${hrf}']`)[0].style.color = 'lightgreen'
  }
}

window.disableUpvotedPlates = disableUpvotedPlates

function updatePlateScore(h){
  originalNum = parseInt(document.getElementById(h).innerHTML)
  document.getElementById(h).innerHTML = (originalNum + 1).toString()
}

window.updatePlateScore = updatePlateScore
