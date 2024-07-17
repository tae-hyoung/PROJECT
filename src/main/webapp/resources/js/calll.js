let data;

let currentWeekStart = getStartOfWeek(new Date()); // 현재 주의 시작 날짜
const today = new Date(); // 오늘 날짜

// 날짜를 'YYYY-MM-DD' 형식으로 포맷하는 함수
function formatDate(date) {
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const day = date.getDate().toString().padStart(2, '0');
  return `${year}/${month}/${day}`;
}

// 시작 날짜를 기준으로 주간 날짜 배열을 생성하는 함수
function getWeekDates(startDate) {
  const dates = [];
  for (let i = 0; i < 7; i++) {
    const date = new Date(startDate);
    date.setDate(startDate.getDate() + i);
    dates.push(formatDate(date));
  }
  return dates;
}

// 화면에 주간 날짜를 업데이트하는 함수
function updateWeekDates() {
  const weekDates = getWeekDates(currentWeekStart);
  $('#weekDates').text(`${weekDates[0]} ~ ${weekDates[6]}`);
  for (let i = 0; i < 7; i++) {
    $(`#day${i}`).text(weekDates[i]).removeClass("lightblue");
    if (weekDates[i] === formatDate(today)) {
      $(`#day${i}`).addClass("lightblue");
    }
  }
  timetable(); // 주간 날짜가 업데이트될 때 시간표도 다시 생성
}

let hour;

// 시간표 테이블을 생성하는 함수
function timetable() {
  const tbody = $('#timetable tbody');
  tbody.empty();
  const weekDates = getWeekDates(currentWeekStart); // 현재 주의 날짜 배열을 가져옴

  for (let i = 9; i < 23; i++) {
    hour = (i < 10) ? "0" + i : i;
    let row = $('<tr></tr>');

    row.append('<th class="time">' + hour + ':00</th>');
    for (let j = 0; j < 7; j++) {
      let cell = $('<td class="btnclick"></td>');
      cell.data('date', weekDates[j]); // 각 셀에 날짜를 저장
      cell.data('time', hour + ':00'); // 각 셀에 시간을 저장

      // 지난 시간 블락처리
      let cellDateTime = new Date(weekDates[j] + ' ' + hour + ':00');
      if (cellDateTime < today) {
        cell.addClass('past').removeClass('btnclick');
      }

      row.append(cell);
    }

    tbody.append(row);
  }
}

// 오늘 날짜가 포함된 주의 시작 날짜를 계산하는 함수 (일요일을 시작일로 설정)
function getStartOfWeek(date) {
  const day = date.getDay();
  const diff = date.getDate() - day;
  return new Date(date.setDate(diff));
}

// 문서가 준비되면 실행
$(document).ready(function () {
  updateWeekDates();

  // 이전 주 버튼 클릭 이벤트
  $('#prevWeek').on('click', function () {
    currentWeekStart.setDate(currentWeekStart.getDate() - 7);
    updateWeekDates();
  });

  // 다음 주 버튼 클릭 이벤트
  $('#nextWeek').on('click', function () {
    currentWeekStart.setDate(currentWeekStart.getDate() + 7);
    updateWeekDates();
  });

  // 오늘 버튼 클릭 이벤트
  $('#todayBtn').on('click', function () {
    currentWeekStart = getStartOfWeek(new Date(today));
    updateWeekDates();
  });

  // 테이블 셀 클릭 이벤트
  $(document).on("click", "td.btnclick", function () {
    $(this).toggleClass("gray");
  });

  // 예약 버튼 클릭 이벤트
  $("#reBtn").on("click", function () {
    let selectedSeats = {};

    // 선택한 좌석 시간을 수집
    $("#timetable tbody tr").each(function () {
      $(this).find('td.gray').each(function () {
        let date = $(this).data('date');
        let time = $(this).data('time');
        if (!selectedSeats[date]) {
          selectedSeats[date] = [];
        }
        selectedSeats[date].push(time);
      });
    });

    const selectedDates = Object.keys(selectedSeats);
    const selectedTimes = Object.values(selectedSeats);

    // 예약 정보와 시간을 준비
    let reservationInfo = "";
    let beginTm, endTm;

    for (const [day, times] of Object.entries(selectedSeats)) {
      let startTime = times[0];
      let endTime = times[times.length - 1];

      // 종료 시간에 한 시간 더하기
      let endHour = parseInt(endTime.split(':')[0]) + 1;
      endHour = endHour < 10 ? "0" + endHour : endHour;

      reservationInfo += `요일: ${day}, 시작시간: ${startTime}, 종료시간: ${endHour}:00\n`;

      let fullStartTime = `${day} ${startTime}`;
      let fullEndTime = `${day} ${endHour}:00`;

      if (!beginTm || fullStartTime < beginTm) beginTm = fullStartTime;
      if (!endTm || fullEndTime > endTm) endTm = fullEndTime;
    }

    console.log("선택한 날짜:", selectedDates[0]);
    console.log("선택한 시간:", selectedTimes);

    console.log("선택한 코트:", $('#seat').val());
    console.log("인원수:", $("#nop").val());

    console.log("beginTm:", beginTm);
    console.log("endTm:", endTm);

    let seat = $('#seat').val();
    let nop = $("#nop").val();
    data = {
      "regDt": selectedDates[0],
      "beginTm": beginTm,
      "endTm": endTm,
      "seat": seat,
      "nop": nop
    };
  });
});
