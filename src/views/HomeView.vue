<script setup lang="ts">
import { ref, watch } from 'vue'
import { useWindowScroll } from '@vueuse/core';

const { y } = useWindowScroll()
watch((y),(newVal)=>{
  if(newVal == 300){
    startIncrement()
  }
})
const currentNumber = ref(0)
const formattedNumber = ref('')
const startIncrement = () => {
  let targetNumber = 987655873; // 目標數字
  let duration = 1000; // 動畫持續時間（毫秒）
/**
 * @param increment 算出每次要加的數量
 * - (duration / 16) 是多久要加一次
 * - targetNumber / (duration / 16) 是一次要加多少
 *
 * 簡單來說就是：
 * - 每次加 5267497
 * - 但時間還是要看電腦的速度 我只是算出每次會加的數量而已
 *
 */
  let increment = targetNumber / (duration / 16);
  currentNumber.value += Number(increment.toFixed(0))
  formattedNumber.value = currentNumber.value.toLocaleString();
  if(currentNumber.value < targetNumber){
    window.requestAnimationFrame(startIncrement)
  } else {
    formattedNumber.value = targetNumber.toLocaleString()
  }
};
</script>

<template>
  <div class="body">
    <div class="container">
      <div class="header" style="height: 811px;">
        <div class="header-text">
          <img src="../assets/image//header-text.png" alt="標頭文字" class="mb-4">
          <p>我是鬥立翰，堅守正義、追求共融，</p>
          <p>望與人類共同塑造更美好的明天。</p>
          <RouterLink to="" class="btn btn-outline-light text-info rounded-5 py-2 px-3">認識候選人</RouterLink>
        </div>
        <div class="seal">
          <img src="../assets/image/seal.png" alt="狗的印章">
        </div>
        <div class="header-image">
          <img src="../assets/image/header.png" alt="標頭鬥牛犬">
        </div>
      </div>
      <div class="introduce row">
        <div class="col-6 me-4">
          <div class="donate bg-light rounded-4 w-100">
            <div>
              <h3>小額捐款</h3>
              <p class="text-warning mt-4 mb-1">您的小筆捐款，</p>
              <p class="text-warning">是每隻毛孩未來的大大動力！</p>
              <span>目前小額贊助總金額：{{ formattedNumber }}</span>
              <RouterLink to="" class="btn btn-outline-warning text-light rounded-5 py-2 px-4">我要捐款</RouterLink>
              <div class="donate-image">
                <img src="../assets/image/donate-img.png" alt="logo" >
              </div>
            </div>
          </div>
          <div>
            <h3 class="text-info">鬥立翰（Dog Li-Han）</h3>
            <p>我堅信推動更完善的狗狗福利和相關政策，能間接地發展台灣的未來。畢竟，狗狗療育的存在能幫助改善人民身心健康，進而賺更多的錢，激發工作熱情、推動經濟，為台灣的GDP帶來巨大效益。</p>
            <p>因此，我期望能在立法院推進政策，確保狗狗和人類都能得到最大的福祉。護航台灣的幸福，就從照顧狗狗開始！</p>
          </div>
        </div>
        <div class="activity col-5">
          <h2 class="mb-5">最新活動</h2>
          <div class="row">
            <div class="col-4">
              <img src="../assets/image/Activity1.png" alt="活動圖1">
            </div>
            <div class="col-7">
              <p class="text-info data">12.26</p>
              <p class="activity-title">台北寵物論壇，爭取狗狗友善環境</p>
              <p>炎炎夏日的周六，我帶著鬥牛犬霸氣墨鏡走進了台北寵物論壇，決定要全力宣傳「狗狗傲嬌」的理念！誰說只有貓咪有個性，狗狗也應該活出專屬自己的個性。</p>
            </div>
          </div>
          <div class="w-100 my-4 activity-border"></div>
          <div class="row">
            <div class="col-4">
              <img src="../assets/image/Activity2.png" alt="活動圖2">
            </div>
            <div class="col-7">
              <p class="text-info data">12.24</p>
              <p class="activity-title">掃街模式開啟！鄉親父老一起來！</p>
              <p>街上氣氛真的很棒，從小孩到大人，雖然下起大雨，大家還是穿著雨衣來參加活動，真的太感人了！這次的活動不僅讓我看到大家的熱情，更加堅定了我推進「狗狗友善環境」政策的決心。</p>
            </div>
          </div>
          <div class="w-100 my-4 activity-border"></div>
          <div class="row">
            <div class="col-4">
              <img src="../assets/image/Activity3.png" alt="活動圖3">
            </div>
            <div class="col-7">
              <p class="text-info data">12.20</p>
              <p class="activity-title">收容所模特兒大比拼！</p>
              <p>今天的收容所不再是一片寂靜。為了讓更多人認識到這裡的毛孩子，我們舉辦了一場前所未有的「模特兒走秀」！</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.body{
  background-color: #D9E8FF;
}
.header{
  position: relative;
}
.header-image{
  float: right;
}
.header-text{
  position: absolute;
  top: 280px;
}
.header-text p{
  font-weight: 700;
}
.header-text a{
  font-weight: 500;
}
.seal{
  position:absolute;
  top:574px;
  left:480px
}
.introduce{
  margin-top: 80px;
}
.introduce h3, .introduce h2, .activity .data, .activity-title{
  font-weight: 700;
}
.donate p{
  font-weight: 500;
  font-size: 20px;
  line-height: 32px;
}
.donate span{
  font-weight: 400;
}
.donate{
  height: 35vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  position: relative;
  margin-bottom: 40px;
}
.donate > div{
  margin: 0 40px;
}
.donate-image{
  position: absolute;
  top: 5%;
  left: 50%;
  z-index: 1;
}
.donate a{
  float: right;
  position: absolute;
  top: 60%;
  left: 75%;
  z-index: 2;
}
.activity p:not(.activity-title){
  margin-bottom: 0;
  display: -webkit-box; /* （Chrome、Safari等瀏覽器引擎）私有的 CSS 屬性 */
  -webkit-box-orient: vertical; /* 垂直方向列 */
  overflow: hidden;
  -webkit-line-clamp: 2; /* 顯示的行數 */
}
.activity-title{
  margin-bottom: 5px;
}
.activity .data{
  font-size: 24px;
}
.activity-border{
  border-bottom: 1px solid black;
}
</style>