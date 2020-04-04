document.addEventListener('turbolinks:load', () => {
  const submitButton = document.getElementById("submit_btn");
  const curtain = document.getElementById("curtain");
  const spinner = document.getElementById("spinner");

  submitButton.onclick = function(){
      curtain.style.opacity = 0.65;
      spinner.style.opacity = 1.00;
  };
});
