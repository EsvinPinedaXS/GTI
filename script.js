window.addEventListener('click',function(e){
  var menu = document.getElementById('contextMenu');
  menu.classList.remove('visible');
});
function showContextMenu(e) {
   var pulse = document.getElementById('pulse');
  var menu = document.getElementById('contextMenu');
  if(e.clientX > window.innerWidth- 220) {
    menu.style.left = (e.clientX-220)+'px';
    menu.style.transformOrigin = 'top right';
  } else {
    menu.style.left = e.clientX+'px';      
  }
  pulse.style.left = e.clientX-10+'px';
  menu.style.top = e.clientY+'px';  
  pulse.style.top = (e.clientY-10)+'px';  
  pulse.classList.add('active');
  setTimeout(function(){
    document.getElementById('pulse').classList.remove('active');
  },300);
    document.getElementById('contextMenu')
  menu.classList.add('visible');
  menu.style.transformOrigin = 'top left';
  return false;
}