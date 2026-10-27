"""
Malika Print boti uchun "📖 Katalog" tugmasi (aiogram 3).
Mavjud botingizga shu qismlarni qo'shasiz.
"""
from aiogram import Bot, Router
from aiogram.filters import CommandStart
from aiogram.types import (
    Message, WebAppInfo, MenuButtonWebApp,
    InlineKeyboardMarkup, InlineKeyboardButton,
)

# GitHub Pages'ga joylagandan keyin olingan havola (https bilan boshlanishi shart)
CATALOG_URL = "https://SIZNING-LOGIN.github.io/malika-katalog/"

router = Router()


def catalog_keyboard() -> InlineKeyboardMarkup:
    return InlineKeyboardMarkup(inline_keyboard=[
        [InlineKeyboardButton(text="📖 Katalogni ochish", web_app=WebAppInfo(url=CATALOG_URL))]
    ])


@router.message(CommandStart())
async def start(message: Message):
    await message.answer(
        "Assalomu alaykum! Malika Print mahsulotlari katalogini ko'rish uchun tugmani bosing 👇",
        reply_markup=catalog_keyboard(),
    )


async def set_menu_button(bot: Bot):
    """Chat pastidagi chap tomonda doimiy "Katalog" tugmasi.
    Bot ishga tushganda bir marta chaqiring:  await set_menu_button(bot)"""
    await bot.set_chat_menu_button(
        menu_button=MenuButtonWebApp(text="Katalog", web_app=WebAppInfo(url=CATALOG_URL))
    )
