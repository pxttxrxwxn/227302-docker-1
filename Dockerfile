# 1. เลือก Base Image เป็น Node.js เวอร์ชัน 18 (หรือเวอร์ชันที่คุณใช้)
# แนะนำรุ่น -alpine เพราะขนาดไฟล์เล็กมาก (ประมาณ 40MB เทียบกับปกติ 900MB+)
FROM node:18-alpine

# 2. กำหนดโฟลเดอร์ทำงานภายใน Container
WORKDIR /app

# 3. คัดลอกเฉพาะไฟล์ package เพื่อลง library ก่อน (Technique: Layer Caching)
# ทำแบบนี้ ถ้า Code เปลี่ยน แต่ Library ไม่เปลี่ยน Docker จะข้ามขั้นตอนนี้ไปเลย (Build ไวขึ้น)
COPY package*.json ./

# 4. ติดตั้ง Library (ใช้ npm ci จะดีกว่า npm install ใน production เพราะแม่นยำกว่า)
RUN npm ci --only=production

# 5. คัดลอก Source Code ทั้งหมดเข้าไป
COPY . .

# 6. (Optional) เปลี่ยน User จาก root เป็น 'node' เพื่อความปลอดภัย
USER node

# 7. บอกว่าจะเปิด Port อะไร (เช่น 3000 หรือ 8080 ตาม code ของคุณ)
EXPOSE 3000

# 8. คำสั่งรันโปรแกรม
# แนะนำให้เรียก node โดยตรง แทน npm start เพื่อการจัดการ signal ที่ดีกว่า
CMD ["node", "app.js"]
