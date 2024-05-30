<script setup lang="ts">
import { ref, watch } from 'vue';
import { useWindowScroll, useWindowSize } from '@vueuse/core';
import { Swiper, SwiperSlide } from 'swiper/vue';
import 'swiper/css';
import 'swiper/css/pagination';
import { Pagination, Autoplay } from 'swiper/modules';
import { Form, Field, defineRule, configure } from 'vee-validate';
import { required, email, integer } from '@vee-validate/rules';
import { localize, setLocale } from '@vee-validate/i18n';
import zhTW from '@vee-validate/i18n/dist/locale/zh_TW.json';

const { width, height } = useWindowSize();

/**
 * veeVaildate註冊
 */
configure({
  generateMessage: localize({ zh_TW: zhTW }),
  validateOnInput: true
});
setLocale('zh_TW');
/**
 * veeVaildate註冊rules
 */
defineRule('required', required);
defineRule('email', email);
defineRule('integer', integer);
defineRule('phone_tw', (value: string) => {
  const regex = /^(09)[0-9]{8}$/;
  if (!regex.test(value)) {
    return '請輸入09開頭的手機號碼';
  }
  return true;
});

const modules = [Pagination, Autoplay];

const { y } = useWindowScroll();
watch(y, (newVal) => {
  if (newVal > 400) {
    startIncrement();
  }
});

/**
 * 儲存每次更新後的值
 */
const currentNumber = ref(0);

const formattedNumber = ref('');

const startIncrement = () => {
  let targetNumber = 987655873; // 目標數字
  let duration = 15000; // 動畫持續時間（毫秒）
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
  let increment = targetNumber / (duration / 16); //算出每秒要加多少值 例:987655873 / (15000 / 16) = 1053499
  currentNumber.value += Number(increment.toFixed(0)); //四捨五入
  formattedNumber.value = currentNumber.value.toLocaleString(); //轉成字串
  if (currentNumber.value < targetNumber) {
    //告訴瀏覽器我們要產生動畫效果
    window.requestAnimationFrame(startIncrement);
  } else {
    //currentNumber.value = targetNumber時 就停止是最終值
    formattedNumber.value = targetNumber.toLocaleString(); //轉成字串
  }
};

function submitForm(data :any) { //TODO:先用any
  console.log(data);
}
</script>

<template>
  <div class="body">
    <div :class="{ container: width >= 1200 }">
      <div class="mb-3 row mx-0">
        <div class="header-text col-xl-6">
          <img src="../assets/image//header-text.png" alt="標頭文字" class="mb-4" />
          <p>我是鬥立翰，堅守正義、追求共融，</p>
          <p>望與人類共同塑造更美好的明天。</p>
          <RouterLink to="" class="btn btn-outline-light text-info rounded-5 py-2 px-3">
            認識候選人
          </RouterLink>
          <div class="seal" v-show="width >= 1200"></div>
        </div>
        <div class="col-xl-6 px-0 position-relative">
          <div class="header-bg"></div>
          <img
            class="header-image"
            width="100%"
            src="../assets/image/headerDog.png"
            alt="標頭鬥牛犬"
          />
          <img v-show="width < 1200" class="header-seal" src="../assets/image/seal2.png" alt="狗腳印">
        </div>
      </div>
    </div>
    <div class="container">
      <div class="introduce row">
        <div class="col-6 me-4">
          <div class="donate bg-light rounded-4 w-100">
            <div>
              <h3>小額捐款</h3>
              <p class="text-warning mt-4 mb-1">您的小筆捐款，</p>
              <p class="text-warning">是每隻毛孩未來的大大動力！</p>
              <span>目前小額贊助總金額：{{ formattedNumber }}</span>
              <div class="donate-image">
                <img class="w-100" src="../assets/image/donate-img.png" alt="logo" />
              </div>
            </div>
            <div>
              <RouterLink to="" class="btn btn-outline-warning text-light rounded-5 py-2 px-4">
                我要捐款
              </RouterLink>
            </div>
          </div>
          <div>
            <h3 class="text-info">鬥立翰（Dog Li-Han）</h3>
            <p>
              我堅信推動更完善的狗狗福利和相關政策，能間接地發展台灣的未來。畢竟，狗狗療育的存在能幫助改善人民身心健康，進而賺更多的錢，激發工作熱情、推動經濟，為台灣的GDP帶來巨大效益。
            </p>
            <p>
              因此，我期望能在立法院推進政策，確保狗狗和人類都能得到最大的福祉。護航台灣的幸福，就從照顧狗狗開始！
            </p>
          </div>
        </div>
        <div class="activity col-5">
          <h2 class="mb-5">最新活動</h2>
          <div class="row">
            <div class="col-4">
              <img src="../assets/image/Activity1.png" alt="活動圖1" />
            </div>
            <div class="col-7">
              <p class="text-info data">12.26</p>
              <p class="activity-title">台北寵物論壇，爭取狗狗友善環境</p>
              <p>
                炎炎夏日的周六，我帶著鬥牛犬霸氣墨鏡走進了台北寵物論壇，決定要全力宣傳「狗狗傲嬌」的理念！誰說只有貓咪有個性，狗狗也應該活出專屬自己的個性。
              </p>
            </div>
          </div>
          <div class="w-100 my-4 activity-border"></div>
          <div class="row">
            <div class="col-4">
              <img src="../assets/image/Activity2.png" alt="活動圖2" />
            </div>
            <div class="col-7">
              <p class="text-info data">12.24</p>
              <p class="activity-title">掃街模式開啟！鄉親父老一起來！</p>
              <p>
                街上氣氛真的很棒，從小孩到大人，雖然下起大雨，大家還是穿著雨衣來參加活動，真的太感人了！這次的活動不僅讓我看到大家的熱情，更加堅定了我推進「狗狗友善環境」政策的決心。
              </p>
            </div>
          </div>
          <div class="w-100 my-4 activity-border"></div>
          <div class="row">
            <div class="col-4">
              <img src="../assets/image/Activity3.png" alt="活動圖3" />
            </div>
            <div class="col-7">
              <p class="text-info data">12.20</p>
              <p class="activity-title">收容所模特兒大比拼！</p>
              <p>
                今天的收容所不再是一片寂靜。為了讓更多人認識到這裡的毛孩子，我們舉辦了一場前所未有的「模特兒走秀」！
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="candidate-say row">
      <div class="candidate-bg"></div>
      <div class="candidate-bg"></div>
      <div class="col-6 candidate-text">
        <img src="../assets/image/candidate-say.png" alt="候選人精神答話" />
      </div>
      <div class="col-6 candidate-image"></div>
    </div>
    <div class="bg-white policy-issue">
      <div class="container">
        <h2 class="mb-4 fw-bold">政策議題</h2>
        <div class="row justify-content-between align-items-center container-content">
          <div class="col-5 mb-5 policy-one">
            <p>為毛孩子謀福利！</p>
            <p>推動寵物醫療保障方案</p>
            <RouterLink to="" class="btn px-4 py-2 rounded-5">了解更多</RouterLink>
          </div>
          <div class="col-5 mb-5 policy-two">
            <p>打造休閒天堂！</p>
            <p>推廣寵物休閒與娛樂場所</p>
            <RouterLink to="" class="btn px-4 py-2 rounded-5">了解更多</RouterLink>
          </div>
          <div class="col-5 policy-three">
            <p>讓愛更專業</p>
            <p>推廣寵物飼養教育</p>
            <RouterLink to="" class="btn px-4 py-2 rounded-5">了解更多</RouterLink>
          </div>
          <div class="col-5 policy-four">
            <p>反對外貌歧視！</p>
            <p>破除寵物刻板印象</p>
            <RouterLink to="" class="btn px-4 py-2 rounded-5">了解更多</RouterLink>
          </div>
        </div>
      </div>
    </div>
    <div class="text-center swiper-main">
      <Swiper
        :slidesPerView="5"
        :spaceBetween="10"
        :loop="true"
        :autoplay="{ delay: 1000, disableOnInteraction: false }"
        :pagination="{
          clickable: true,
          el: null
        }"
        :modules="modules"
        class="mySwiper"
      >
        <SwiperSlide><img src="../assets/image/swiper1.png" alt="" /></SwiperSlide>
        <SwiperSlide><img src="../assets/image/swiper2.png" alt="" /></SwiperSlide>
        <SwiperSlide><img src="../assets/image/swiper3.png" alt="" /></SwiperSlide>
        <SwiperSlide><img src="../assets/image/swiper4.png" alt="" /></SwiperSlide>
        <SwiperSlide><img src="../assets/image/swiper5.png" alt="" /></SwiperSlide>
        <SwiperSlide><img src="../assets/image/swiper6.png" alt="" /></SwiperSlide>
        <SwiperSlide><img src="../assets/image/swiper7.png" alt="" /></SwiperSlide>
      </Swiper>
    </div>
    <div class="form">
      <h3 class="fw-bold mb-4">民眾服務信箱</h3>
      <p class="fw-bold mb-2">您的聲音，是我們的行動！</p>
      <p>
        今天的收容所不再是一片寂靜。為了讓更多人認識到這裡的毛孩子，我們舉辦了一場前所未有的「模特兒走秀」！
      </p>
      <Form class="w-100" @submit="submitForm">
        <div class="formBody">
          <Field name="name" label="姓名" v-slot="{ field, errorMessage }" rules="required">
            <label for="">姓名</label>
            <div class="formInput">
              <input v-bind="field" type="text" placeholder="請輸入姓名" class="p-2 border-0" />
              <span class="text-danger ms-2">{{ errorMessage }}</span>
            </div>
          </Field>
        </div>
        <div class="formBody">
          <Field name="email" label="Email" v-slot="{ field, errorMessage }" rules="required|email">
            <label for="">Email</label>
            <div class="formInput">
              <input v-bind="field" type="text" placeholder="abc@gmail.com" class="p-2 border-0" />
              <span class="text-danger ms-2">{{ errorMessage }}</span>
            </div>
          </Field>
        </div>
        <div class="formBody">
          <Field
            name="phone"
            label="手機"
            v-slot="{ field, errorMessage }"
            rules="required|phone_tw"
          >
            <label for="">手機</label>
            <div class="formInput">
              <input v-bind="field" type="tel" placeholder="0912345678" class="p-2 border-0" />
              <span class="text-danger ms-2">{{ errorMessage }}</span>
            </div>
          </Field>
        </div>
        <div class="formBody">
          <Field name="text" label="建言" v-slot="{ field, errorMessage }" rules="required">
            <label for="">您的建言</label>
            <div class="formInput w-100">
              <textarea
                v-bind="field"
                placeholder="請您的建言或問題"
                class="p-2 border-0 w-50"
                rows="3"
              ></textarea>
              <span class="text-danger ms-2">{{ errorMessage }}</span>
            </div>
          </Field>
        </div>
        <button type="submit" class="btn btn-info rounded-5 px-3">送出意見</button>
      </Form>
    </div>
    <footer class="row align-items-center justify-content-between w-100 m-0">
      <div class="col-5">
        2023 鬥立翰 版權所有。<br />
        <span class="d-inline-block">辦公室地址｜毛孩區，毛茸茸大道99號，狗狗大厦99樓</span>
        <span class="d-inline-block">Tel｜(02)888-5678</span>
        <span class="d-inline-block">Email｜dogoffice@doglihan.tw</span>
      </div>
      <ul class="d-flex justify-content-between col-5">
        <li>首頁</li>
        <li>認識候選人</li>
        <li>最新活動</li>
        <li>政策議題</li>
        <li>小額捐款</li>
      </ul>
    </footer>
  </div>
</template>

<style scoped>
.body {
  background-color: #d9e8ff;
  position: relative;
}
.header-bg {
  background-color: #6386d1;
  border-radius: 0 0 45px 45px;
  padding: 0;
  height: 100%;
  position: absolute;
  width: 100%;
  z-index: 1;
}
.header-image {
  float: right;
  border-radius: 0 0 45px 45px;
  position: relative;
  z-index: 10;
}
.header-text {
  margin: auto;
  position: relative;
  z-index: 99;
}
.header-text p {
  font-weight: 700;
}
.header-text a {
  font-weight: 500;
}
.seal {
  background-image: url('../assets/image/seal.png');
  width: 197px;
  height: 197px;
  position: absolute;
  right: -47px;
}
.introduce {
  margin-top: 80px;
}
.introduce h3,
.introduce h2,
.activity .data,
.activity-title {
  font-weight: 700;
}
.donate p {
  font-weight: 500;
  font-size: 20px;
  line-height: 32px;
}
.donate span {
  font-weight: 400;
}
.donate {
  height: 35vh;
  display: flex;
  align-items: center;
  justify-content: space-around;
  position: relative;
  margin-bottom: 40px;
}
.donate-image {
  position: absolute;
  top: 5%;
  left: 50%;
  z-index: 1;
}
.activity p:not(.activity-title) {
  margin-bottom: 0;
  display: -webkit-box; /* （Chrome、Safari等瀏覽器引擎）私有的 CSS 屬性 */
  -webkit-box-orient: vertical; /* 垂直方向列 */
  overflow: hidden;
  -webkit-line-clamp: 2; /* 顯示的行數 */
}
.activity-title {
  margin-bottom: 5px;
}
.activity .data {
  font-size: 24px;
}
.activity-border {
  border-bottom: 1px solid black;
}
.candidate-say {
  margin: 80px 0px 0px 0px;
  height: 310px;
  position: relative;
  max-width: 100%;
}
.candidate-text {
  z-index: 8;
  height: 310px;
  background-color: rgba(239, 239, 239, 1);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
}
.candidate-image {
  background-image: url('../assets/image/candidate.png');
  background-size: cover;
  background-position: center center;
  z-index: 8;
  padding: 0;
}
.candidate-bg {
  width: 30%;
  height: 310px;
  left: 45%;
  background: linear-gradient(to right, rgba(239, 239, 239, 1), rgba(239, 239, 239, 0));
  position: absolute;
  z-index: 9;
}
.container-content > div {
  background-size: cover;
  background-position: center center;
  height: 300px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 25px;
}
.container-content > div p {
  font-weight: 700;
  font-size: 22px;
}
.container-content > div a {
  color: #ef6a23;
  background-color: white;
}
.container-content > div a:hover {
  color: white;
  background-color: #ef6a23;
}
.policy-issue {
  padding: 80px 0px 200px 0;
}
.policy-one {
  background: linear-gradient(0deg, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 0.7)),
    url('../assets/image/policy1.png');
}
.policy-two {
  background: linear-gradient(0deg, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 0.7)),
    url('../assets/image/policy2.png');
}
.policy-three {
  background: linear-gradient(0deg, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 0.7)),
    url('../assets/image/policy3.png');
}
.policy-four {
  background: linear-gradient(0deg, rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 0.7)),
    url('../assets/image/policy4.png');
}
.swiper-main {
  width: 100%;
  height: 238px;
  margin-top: -120px;
}
.form {
  height: 868px;
  width: 50%;
  margin: auto;
  margin-top: 60px;
}
.form .formBody {
  position: relative;
  margin: 30px;
}
.form .formBody .formInput {
  position: absolute;
  left: 100px;
  top: 0;
}
Form > button {
  float: right;
  margin-top: 80px;
}
ul {
  list-style: none;
}
footer {
  padding: 32px 40px;
  background-color: #ffff;
}
@media (max-width: 1199px) {
  .body {
    padding-top: 80px;
  }
  .seal {
    position: static;
  }
  .header-text {
    padding: 0 48px;
  }
  .header-bg {
    width: 90%;
    height: 45%;
    border-radius: 0 45px 0 0;
    position: absolute;
    bottom: 0;
    z-index: 1;
  }
  .header-image {
    position: relative;
    border-radius: 0;
    z-index: 2;
  }
  .header-seal{
    position: absolute;
    z-index: 3;
    bottom: 5%;
    left: 15%;
  }
}
</style>
