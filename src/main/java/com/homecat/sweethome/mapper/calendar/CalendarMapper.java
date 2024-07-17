package com.homecat.sweethome.mapper.calendar;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.calendar.CalendarVO;

public interface CalendarMapper {

	public List<CalendarVO> list(Map<String, Object> map);

	public int addEvent(CalendarVO calendarVO);

	public CalendarVO detail(CalendarVO calendarVO);

	public int updateEvent(CalendarVO calendarVO);

	public int deleteEvent(CalendarVO calendarVO);

	public List<CalendarVO> adminCalList(Map<String, Object> map);

	public int adminAddEvent(CalendarVO calendarVO);

	public CalendarVO adminDetailEvent(CalendarVO calendarVO);

	public int adminUpdateEvent(CalendarVO calendarVO);

	public int adminDeleteEvent(CalendarVO calendarVO);

	public int dragUp(CalendarVO calendarVO);

	public int isEventExists(CalendarVO calendarEvent);




}
