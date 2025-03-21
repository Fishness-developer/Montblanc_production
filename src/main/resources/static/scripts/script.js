

// MODAL FORM
function open_autorization() {
    document.querySelector("[data-modal-autorization]").classList.toggle("hide")
}

function close_autorization() {
    document.querySelector("[data-modal-autorization]").classList.toggle("hide")
}

// Slider
const slides = document.querySelectorAll(".slider__items-inner")
let slideIndex = 0
let intervalId = null

document.addEventListener("DOMContentLoaded", initilizatioin)

function initilizatioin() {
    slides[slideIndex].classList.add("flex")
    intervalId = setInterval(nextSlide, 5000)
}

function showSlides(index) {
    if (index >= slides.length) {
        slideIndex = 0
    } else if (index < 0) {
        slideIndex = slides.length - 1
    }
    slides.forEach(slide => {
        slide.classList.remove("flex")
    })
    slides[slideIndex].classList.add("flex")
}

function prevSlide() {
    slideIndex--
    showSlides(slideIndex)
}

function nextSlide() {
    slideIndex++
    showSlides(slideIndex)
}