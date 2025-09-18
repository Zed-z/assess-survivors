extends GdUnitTestSuite


func test_sba_erase():
	var sba := SwapbackArray.new(5)
	sba.append(1)
	sba.append(2)
	sba.append(3)
	sba.append(4)
	sba.erase(2)

	assert_array(sba.array_clean).is_equal([1, 4, 3])


func test_sba_iterate():
	var sba := SwapbackArray.new(5)
	sba.append(1)
	sba.append(2)
	sba.append(3)

	var iter_count: int = 0
	var iter_sum: int = 0

	for x in sba:
		iter_count += 1
		iter_sum += x

	assert_int(iter_count).is_equal(3)
	assert_int(iter_sum).is_equal(6)
