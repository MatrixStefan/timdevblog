$ ->
  collapsibles = document.getElementsByClassName("collapsible");

  $(document).on 'click', '.collapsible', ->
    this.classList.toggle("active");
    content = this.nextElementSibling;
    if (content.style.display == "block")
      content.style.display = "none"
      this.querySelector('.indicator').textContent = '+'
    else
      content.style.display = "block"
      this.querySelector('.indicator').textContent = '-'