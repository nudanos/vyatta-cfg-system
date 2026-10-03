TESTS = vyatta-pxe-boot.sh

check:
	ln -s ../scripts/yangop-get-sensor yangop_get_sensor.py
	python3 -m unittest test_yangop_get_sensor
	prove vyatta-show-version.t
	bash time-zone-validate.sh
