let date = new Date();

const renderCalendar = () => {
  const viewYear = date.getFullYear();
  const viewMonth = (date.getMonth() + 1).toString().padStart(2, '0');

  // year-mon 채우기
  document.querySelector('.year-mon').textContent = `${viewYear}년 ${viewMonth}월`;

  // 지난 달 마지막 Date, 이번 달 마지막 Date
  const prevLast = new Date(viewYear, date.getMonth(), 0);
  const thisLast = new Date(viewYear, date.getMonth() + 1, 0);

  // 여기에 달력을 그리는 로직을 추가해야 합니다.
}

renderCalendar();

const prevMonth = () => {
  date.setDate(1);
  date.setMonth(date.getMonth() - 1);
  renderCalendar();
}

const nextMonth = () => {
  date.setDate(1);
  date.setMonth(date.getMonth() + 1);
  renderCalendar();
}

const goToday = () => {
  date = new Date();
  renderCalendar();
}
