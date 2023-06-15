# MovieGuide
 MovieGuide by me 
 
miniproject (เขียนเองยังไม่เสร็จ เพิ่มเรื่อยๆ ทำเอาเท่)

Service -> https://developers.themoviedb.org/3/getting-started/introduction


## Update
13/06/2023
- ปรับ Layout ใหม่
- ปรับการเข้า App ครั้งแรกใหม่
- เพิ่มการ Share Appdelegate
- ปรับ func บางอย่างไปใช้แบบ Extension เอาจะได้ไม่ต้องใส่ทุกหน้า
- เพิ่ม service การแสดง Detail Tv series 
- เพิ่ม service Tvpopular แต่ยังไม่รู้จะใส่หน้าไหน
สิ่งที่จะทำเพิ่มต่อไป
1. เพิ่ม Banner Admob + App Open
2. Tab 1 ทำเป็น 2 Segment : Popular และ Upcoming(Banner) อยู่หน้าเดียวกัน, Top Rate --- ปัจจุบันตอนนี้แสดงอยู่คือ Banner ใช้ data Top Rate
3. Tab 2 ทำเป็น 4 Segment : Airing Today, On The Air, Popular, Top Rated(แสดงอยู่ปัจจุบัน)
4. เพิ่ม Tab 3 โชว์ icon app + version app + Copy right ----> (พวกแชร์, ให้คะแนนแอพ ไม่ต้องเพิ่ม ไม่ได้อัพ Store)

14/06/2023
- ปรับ Tabbar 1 ใหม่ เพิ่ม 2 Segment แยกเป็น Popular กับ Top Rated
- ปรับ service การแสดงผลของ Tabbar 1 ทั้ง 2 segment ใหม่
- ดักการแสดงผล Banner Coming กรณีไม่มีค่ามา สั่งซ่อนไป
- ปรับการแสดงผล Tabbar Background ใหม่
สิ่งที่จะทำเพิ่มต่อไป
1. เพิ่ม Banner Admob + App Open
2. Tab 2 ทำเป็น 4 Segment : Airing Today, On The Air, Popular, Top Rated(แสดงอยู่ปัจจุบัน)
3. เพิ่ม Tab 3 โชว์ icon app + version app + Copy right ----> (พวกแชร์, ให้คะแนนแอพ ไม่ต้องเพิ่ม ไม่ได้อัพ Store)
4. น่าจะต้องเก็บ catch ภาพ โดยให้สั่งเก็บแต่ละวัน ขึ้นวันใหม่ให้ลบ catch เก่าทิ้ง แล้วเก็บอันใหม่ น่าจะช่วยเรื่องโหลดภาพช้าเวลาเข้าแอพภายในวันหลายๆ ครั้ง

14/06/2023
- ปรับ Tabbar 2 ใหม่ และเพิ่มหน้า on air ไว้เหลือใส่ Data on air
- เพิ่ม service on air
- เจอบัค Date format ของ TV Detail รอแก้ไข
สิ่งที่จะทำเพิ่มต่อไป
1. เพิ่ม Banner Admob + App Open
2. เพิ่มหน้า On air ใน Tab2 segment 3
3. เพิ่ม Tab 3 โชว์ icon app + version app + Copy right ----> (พวกแชร์, ให้คะแนนแอพ ไม่ต้องเพิ่ม ไม่ได้อัพ Store)
4. น่าจะต้องเก็บ catch ภาพ โดยให้สั่งเก็บแต่ละวัน ขึ้นวันใหม่ให้ลบ catch เก่าทิ้ง แล้วเก็บอันใหม่ น่าจะช่วยเรื่องโหลดภาพช้าเวลาเข้าแอพภายในวันหลายๆ ครั้ง

15/06/2023
- เพิ่ม Admob Banner
- เพิ่ม on air Tv series
สิ่งที่จะทำเพิ่มต่อไป
1. เพิ่ม Tab 3 โชว์ icon app + version app + Copy right ----> (พวกแชร์, ให้คะแนนแอพ ไม่ต้องเพิ่ม ไม่ได้อัพ Store)
2. น่าจะต้องเก็บ catch ภาพ โดยให้สั่งเก็บแต่ละวัน ขึ้นวันใหม่ให้ลบ catch เก่าทิ้ง แล้วเก็บอันใหม่ น่าจะช่วยเรื่องโหลดภาพช้าเวลาเข้าแอพภายในวันหลายๆ ครั้ง
3. ระบบ Login Firebase
4. push Notification (อาจจะทำ)
