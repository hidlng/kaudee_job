# Kaudee 
----

## Rent API Dev Server v0.1

## Map
----
### Map List(Room marker 한꺼번에 표시)
- URL : `/map/list`
- METHOD : `GET`
- QUERY
> - 사용자 ID 로 검색 : `/map/list?user_id={user_id}`
> - 상점 이름으로 검색 : `/map/list?roomname={marketname}` , 아직 처리중...
> - 주소로 검색 : `/map/list?location={location}`
> - 좌표로 검색 : `/map/list?lat={latitude}&lng={longitude}`
> - 표시영역으로 검색 : `/map/list?bounds=[36.12313, 36.123213, 39.12321, 39.12321]`
- CALLBACK
> - 특정 마커를 클릭: `move://{count: 마커갯수}` 호출
> - 페이지 로딩이 완료되면: `app://init` 호출
- COMMENT
> 비엔티안 기준으로 주변 상점들을 한꺼번에 표시

----
### Map (특정 Room 표시)
- URL : `/map/{id}`
- METHOD : `GET`
- QUERY
> 특별한 쿼리 없음
- COMMENT
> 특정 위치의 상점 1개만 표시할때 사용

----
### Map (상점 위치 찾기)
- URL : `/map/new`
- METHOD : `GET`
- QUERY
> 특정 위치에 마커를 찍고 지도 표시 : `/map/new?lat=17.58&lng=102.36
- COMMENT
> 상점의 위치를 지도상에서 사용자가 찾아서 저장해주고 싶을때 사용할 페이지
- CALLBACK
> 지도를 클릭하면 클릭한 위치로 마커를 옮기고
> latlng://{lat:17.58, lng:102.36} 과 같이 이동 좌표 값을 전달하는 location 변경 이벤트를 발생시킨다.

----



## API
----
### USER
- URL : `/api/v1/user/{id}`
- METHOD : `GET / POST / PUT / DELETE`
- PARAMS
		{
			"email": "abc@sample.com",
			"password": "324nfdns2kjfabf1", #md5 hash password
			"name": "testor",
			"sex": "m",
			"tel": "192-2132-1232",
			"birthdate": "1201",
			"usertype": "user",
			"empno": "",  //사원번호
			"recomno": "" //추천인번호
		}
- RESPONSE
		{ 
			"email": "abc@sample.com",
			"password": "324nfdns2kjfabf1", #md5 hash password
			"name": "testor",
			"sex": "m",
			"tel": "192-2132-1232",
			"usertype": "user",
			"empno": "",
			"recomno": ""
		}
- QUERY
> 준비중..
- COMMENT
> 사용 등록, 조회, 수정, 삭제 API.회
> usertype 으로 일반 사용자인지, 상점등록 사용자인지 구분한다.
> usertype
----


### LOGIN/LOGOUT
- URL : `/api/v1/login`
- METHOD : `POST`
- PARAMS
		{
			"email": "abc@sample.com",
			"password": "324nfdns2kjfabf1" #md5 hash password
		}
- RESPONSE
		{
			"result": true,
			"email": "abc@sample.com",
			"password": "324nfdns2kjfabf1",
			"sex": "m",
			"tel": "1234-123-123",
			"birthdate": "1201",
			"address": "sample marekt address",
			"cellphone": "111-222-3333",
			"access_token": "13909dsfasdfjjfas87"
		}
- QUERY
> 특수한 쿼리 없음.
- COMMENT
> 사용자 로그인 로그아웃 API.
> Access Token 을 얻기 위해서 호출해야 한다.
----


### ROOM 
- URL : `/api/v1/room/{id}`
- METHOD : `GET / POST / PUT / DELETE`
- PARAMS
		{
		    "apikey": "13909dsfasdfjjfas87",
		    "roomname": "sample room",
		    "roomname_lao": "sample room ບັນຊ",
		    "user_id": 1,
		    "address": "test address",
		    "address_lao": "test address lao",
		    "cellphone": "333-4444-4444",
		    "tel": "123-452-1134",
		    "email": "1@1.2",
		    "latitude": "21.2312321312",
		    "longitude": "32.42132132",
		    "delyn": "no",
		    "detail_lao": "detail lao test",
		    "detail_eng": "detail eng test",
		    "deposit": 2000,
		    "rent": 101,
		    "rstruct": "one room",
		    "rcount": 1,
		    "bcount": 1,
		    "bform": "apartment",
		    "bfloor": 3,
		    "parea": 11,
		    "aarea": 12,
		    "options": "sink, air con",
		    "mexpenses": 100,
		    "livedays": 90,
		    "parkingyn": "yes",
		    "elevatoryn": "no",
		    "poolyn": "no",
		}
- RESPONSE
		{
		    "id": 1,
		    "roomname": "sample room",
		    "roomname_lao": "sample room ບັນຊ",
		    "user_id": 1,
		    "address": "test address",
		    "address_lao": "test address lao",
		    "cellphone": "333-4444-4444",
		    "tel": "123-452-1134",
		    "email": "1@1.2",
		    "latitude": "21.2312321312",
		    "longitude": "32.42132132",
		    "delyn": "no",
		    "detail_lao": "detail lao test",
		    "detail_eng": "detail eng test",
		    "deposit": 2000,
		    "rent": 101,
		    "rstruct": "one room",
		    "rcount": 1,
		    "bcount": 1,
		    "bform": "apartment",
		    "bfloor": 3,
		    "parea": 11,
		    "aarea": 12,
		    "options": "sink, air con",
		    "mexpenses": 100,
		    "livedays": 90,
		    "parkingyn": "yes",
		    "elevatoryn": "no",
		    "poolyn": "no",
		    "created_at": "2015-03-18T16:27:37.072Z",
		    "updated_at": "2015-03-18T16:27:37.072Z",
		    "image": []
		}

- QUERY
> 준비중..
- COMMENT
> 상점 등록, 조회, 수정, 삭제 API.
> Access Token 이 필요하다.
----


### FAVORITE
- URL : `/api/v1/favorite/{id}`
- METHOD : `GET / POST / PUT / DELETE`
- PARAMS
		{
			"apikey": "13909dsfasdfjjfas87",
			"user_id": 1,
			"room_id": 1
		}
- RESPONSE
		{
			"result": true,
			"id": 1,
			"user_id": 1,
			"room_id": 1
		}
- QUERY
> - 사용자ID 로 검색 : `/api/v1/favorite?user_id=1&apikey=~~~~`
> - Paging :  `/api/v1/favorite?page=1&user_id=1&apikey=~~~~`
- COMMENT
> 즐겨찾기 등록, 조회, 수정, 삭제 API.
> Access Token 이 필요하다.
----


### Image
- URL : `/api/v1/image`
- METHOD : `POST`
- PARAMS
		{
			"room_id": 1,
			"img": <image_file>
		}
- RESPONSE
		{
			"room_id": 1,
			"img": <image_file_path>
		}
- QUERY
> 준비중...
- COMMENT
> 이미지 파일을 업로드 할 수 있는 API
