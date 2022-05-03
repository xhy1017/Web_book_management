var my_back_to_top = document.getElementById('back_to_top');
window.onscroll = function() {
    my_back_to_top.style.display = 'block';
    var height = document.documentElement.scrollTop || document.body.scrollTop;
    if(height === 0) {
        my_back_to_top.style.display = 'none';
    }
}
my_back_to_top.onclick = function() {
    var height = document.documentElement.scrollTop || document.body.scrollTop;
    var t = setInterval(() => {
        height -= 50;
        if (height > 0) {
            window.scrollTo(0, height);
        } else {
            window.scrollTo(0, 0);
            clearInterval(t);
        }
        //10ms,滚动一次，一次减少50px；慢慢滚动到顶部为止清空
    }, 10);
}

