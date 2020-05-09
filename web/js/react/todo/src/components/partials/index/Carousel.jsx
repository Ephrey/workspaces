import React from 'react'
import Carousel from 'react-multi-carousel';
import 'react-multi-carousel/lib/styles.css';


function Slider(props) {
    const settings = {
        additionalTransfrom: 0,
        arrows: false,
        autoPlaySpeed: 3000,
        centerMode: false,
        className: "",
        containerClass: "container",
        dotListClass: "",
        draggable: true,
        focusOnSelect: false,
        infinite : true,
        itemClass: "",
        keyBoardControl: true,
        minimumTouchDrag: 80,
        partialVisible: true,
        renderButtonGroupOutside: false,
        renderDotsOutside: false,
        responsive: {
            mobile: {
            breakpoint: {
                max: 1024,
                min: 464
            },
            items: 1,
            partialVisibilityGutter: 105
            }
        },
        showDots: false,
        sliderClass: "",
        slidesToSlide: 1,
        swipeable: true
    }

    const {items} = props;
    return(
        <Carousel {...settings}>
            {items}
        </Carousel>
    );
}

export default Slider;