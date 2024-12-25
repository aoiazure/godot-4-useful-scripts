class_name TimeUtil

const _CONV_FACTOR:= 1000.0

static func get_msec_current_time() -> int:
	return Time.get_ticks_msec()

static func get_sec_current_time() -> float:
	return convert_time_to_secs(Time.get_ticks_msec())

static func has_seconds_elapsed_since(since_time_in_msec: int, time_to_check: float) -> bool:
	return (Time.get_ticks_msec() - since_time_in_msec) >= (time_to_check * _CONV_FACTOR)

static func convert_time_to_secs(time_in_msec: int) -> float:
	return float(time_in_msec) / _CONV_FACTOR




