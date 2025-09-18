extends GdUnitTestSuite


func test_sba_erase():
	var sba := SwapbackArray.new(5)
	sba.add_element(1)
	sba.add_element(2)
	sba.add_element(3)
	sba.add_element(4)
	sba.erase(2)

	assert_array(sba.array).is_equal([1, 4, 3, null, null])
