# encoding: utf-8

include ActionView::Helpers::SanitizeHelper

class YandexMarketApi
  def self.category_xml(category)
    utf8_to_cp1251 "<category id='#{category.id}'>#{category.title}</category>"
  end

  def self.generate_yml
    xml = <<-XML
<?xml version="1.0" encoding="windows-1251"?>
<!DOCTYPE yml_catalog SYSTEM "shops.dtd">
      <yml_catalog date="#{Time.now.strftime("%Y-%m-%d %H:%M")}">
        <shop>
          <name>#{utf8_to_cp1251('Интренет-магазин "Праздник детства"')}</name>
          <company>#{utf8_to_cp1251('ИП Баранова Светлана Владимировна')}</company>
          <url>http://www.prazdnik-magazin.ru/</url>
          <currencies>
            <currency id="RUR" rate="1" plus="0"/>
          </currencies>
          <categories>
            #{Category.all.map{ |c| category_xml(c) }.join}
          </categories>
          <offers>
            #{Product.all.map{ |p| product_xml(p) }.join}
          </offers>
        </shop>
      </yml_catalog>
    XML
  end

  def self.product_xml(product)
    utf8_to_cp1251 <<-OFFER
      <offer id='#{product.id}' available='true' bid='#{product.id}'>
        <url>#{"http://www.prazdnik-magazin.ru/orders/new?product=#{product.id}"}</url>
        <price>#{product.price2 || product.price}</price>
        <currencyId>RUR</currencyId>
        <categoryId>#{product.category_id}</categoryId>
        <picture>#{product.pictures.first.file.url(:large) rescue nil}</picture>
        <store>true</store>
        <pickup>true</pickup>
        <delivery>true</delivery>
        <local_delivery_cost>#{((product.price2 || product.price) > 2000 ? 0 : 300) rescue 300}</local_delivery_cost>
        <name>#{product.title.mb_chars.titleize}</name>
        <vendorCode>#{product.vendor_code}</vendorCode>
        <description>#{strip_tags(product.description.to_s.gsub("&nbsp;", " ")).mb_chars.capitalize}</description>
        <sales_notes>Необходима предоплата.</sales_notes>
        <manufacturer_warranty>true</manufacturer_warranty>
      </offer>
    OFFER
  end

  def self.utf8_to_cp1251(str)
    str.encode(to="WINDOWS-1251", from="UTF-8", :invalid => :replace, :undef => :replace, :replace => "")
  end
end

example = <<SAMPLE
s XML file does not appear to have any style information associated with it. The document tree is shown below.
<yml_catalog date="2010-04-01 17:00">
<shop>
<name>Magazin</name>
<company>Magazin</company>
<url>http://www.magazin.ru/</url>
<currencies>
<currency id="RUR" rate="1" plus="0"/>
</currencies>
<categories>
<category id="1">Оргтехника</category>
<category id="10" parentId="1">Принтеры</category>
<category id="100" parentId="10">Струйные принтеры</category>
<category id="101" parentId="10">Лазерные принтеры</category>
<category id="2">Фототехника</category>
<category id="11" parentId="2">Фотоаппараты</category>
<category id="12" parentId="2">Объективы</category>
<category id="3">Книги</category>
<category id="13" parentId="3">Детективы</category>
<category id="14" parentId="3">Художественная литература</category>
<category id="15" parentId="3">Учебная литература</category>
<category id="16" parentId="3">Детская литература</category>
<category id="4">Музыка и видеофильмы</category>
<category id="17" parentId="4">Музыка</category>
<category id="18" parentId="4">Видеофильмы</category>
<category id="5">Путешествия</category>
<category id="19" parentId="5">Туры</category>
<category id="20" parentId="5">Авиабилеты</category>
<category id="6">Билеты на мероприятия</category>
</categories>
<local_delivery_cost>300</local_delivery_cost>
<offers>
<offer id="12341" type="vendor.model" bid="13" cbid="20" available="true">
<url>http://magazin.ru/product_page.asp?pid=14344</url>
<price>15000</price>
<currencyId>RUR</currencyId>
<categoryId type="Own">101</categoryId>
<picture>http://magazin.ru/img/device14344.jpg</picture>
<delivery>true</delivery>
<local_delivery_cost>300</local_delivery_cost>
<typePrefix>Принтер</typePrefix>
<vendor>НP</vendor>
<vendorCode>Q7533A</vendorCode>
<model>Color LaserJet 3000</model>
<description>
A4, 64Mb, 600x600 dpi, USB 2.0, 29стр/мин ч/б / 15стр/мин цв, лотки на 100л и 250л, плотность до 175г/м, до 60000 стр/месяц
</description>
<manufacturer_warranty>true</manufacturer_warranty>
<country_of_origin>Япония</country_of_origin>
</offer>
<offer id="12342" type="book" bid="17" available="true">
<url>http://magazin.ru/product_page.asp?pid=14345</url>
<price>100</price>
<currencyId>RUR</currencyId>
<categoryId type="Own">13</categoryId>
<picture>http://magazin.ru/img/book14345.jpg</picture>
<delivery>true</delivery>
<local_delivery_cost>300</local_delivery_cost>
<author>Александра Маринина</author>
<name>Все не так. В 2 томах. Том 1</name>
<publisher>ЭКСМО - Пресс</publisher>
<series>А. Маринина - королева детектива</series>
<year>2009</year>
<ISBN>978-5-699-23647-3</ISBN>
<volume>2</volume>
<part>1</part>
<language>rus</language>
<binding>70x90/32</binding>
<page_extent>288</page_extent>
<description>
Все прекрасно в большом патриархальном семействе Руденко. Но — увы! — впечатление это обманчиво: каждого из многочисленных представителей семьи обуревают свои потаенные страсти и запретные желания.
</description>
<downloadable>false</downloadable>
</offer>
<offer id="12343" type="audiobook" bid="17" available="true">
<url>http://magazin.ru/product_page.asp?pid=14346</url>
<price>200</price>
<currencyId>RUR</currencyId>
<categoryId type="Own">14</categoryId>
<picture>http://magazin.ru/img/book14346.jpg</picture>
<author>Владимир Кунин</author>
<name>Иваnов и Rабинович, или Аj'гоу ту 'Хаjфа!</name>
<publisher>1С-Паблишинг, Союз</publisher>
<year>2009</year>
<ISBN>978-5-9677-0757-5</ISBN>
<language>ru</language>
<performed_by>Николай Фоменко</performed_by>
<performance_type>начитана</performance_type>
<storage>CD</storage>
<format>mp3</format>
<recording_length>45m23s</recording_length>
<description>
Перу Владимира Кунина принадлежат десятки сценариев к кинофильмам, серия книг про КЫСЮ и многое, многое другое.
</description>
<downloadable>true</downloadable>
</offer>
<offer id="12344" type="artist.title" bid="11" available="true">
<url>http://magazin.ru/product_page.asp?pid=14347</url>
<price>450</price>
<currencyId>RUR</currencyId>
<categoryId type="Own">17</categoryId>
<picture>http://magazin.ru/img/cd14347.jpg</picture>
<delivery>true</delivery>
<artist>Pink Floyd</artist>
<title>Dark Side Of The Moon, Platinum Disc</title>
<year>1999</year>
<media>CD</media>
<description>
Dark Side Of The Moon, поставивший мир на уши невиданным сочетанием звуков, — это всего-навсего девять треков, и даже не все они писались специально для альбома. Порывшись по сусекам, участники Pink Floyd мудро сделали новое из хорошо забытого старого — песен, которые почему-либо не пошли в дело или остались незаконченными. Одним из источников вдохновения стали саундтреки для кинофильмов, которые группа производила в больших количествах.
</description>
</offer>
<offer id="12345" type="artist.title" bid="56" available="true">
<url>http://magazin.ru/product_page.asp?pid=14348</url>
<price>400</price>
<currencyId>RUR</currencyId>
<categoryId type="Own">18</categoryId>
<picture>http://magazin.ru/img/dvd14348.jpg</picture>
<delivery>true</delivery>
<title>Свадьба Мюриэл</title>
<year>1999</year>
<media>DVD</media>
<starring>
Тони Колетт (Toni Collette), Рэйчел Грифитс (Rachel Griffiths)
</starring>
<director>П Дж Хоген</director>
<originalName>Muriel's wedding</originalName>
<country>Австралия</country>
<description>
Гадкий утенок из провинциального городка покидает свое гнездо, и в компании своей подруги отправляется искать веселой жизни в большой и загадочный город. Фильм о мечтах и реальности, дружбе и юности молодой девушки, приключения которой повторяют судьбы Золушки и героини Джулии Робертс из ставшего классикой фильма Красотка...
</description>
</offer>
<offer id="12346" type="tour" bid="71" available="true">
<url>http://magazin.ru/product_page.asp?pid=14349</url>
<price>30000</price>
<currencyId>RUR</currencyId>
<categoryId type="Own">19</categoryId>
<picture>http://magazin.ru/img/travel14349.jpg</picture>
<delivery>false</delivery>
<local_delivery_cost>300</local_delivery_cost>
<worldRegion>Африка</worldRegion>
<country>Египет</country>
<region>Хургада</region>
<days>7</days>
<dataTour>01/06/10</dataTour>
<dataTour>08/06/10</dataTour>
<name>Hilton</name>
<hotel_stars>5*****</hotel_stars>
<room>SNG</room>
<meal>ALL</meal>
<included>
авиаперелет, трансфер, проживание, питание, страховка
</included>
<transport>Авиа</transport>
<description>Отдых в Египте.</description>
</offer>
<offer id="12347" type="event-ticket" bid="13" available="true">
<url>http://magazin.ru/product_page.asp?pid=14350</url>
<price>5000</price>
<currencyId>RUR</currencyId>
<categoryId type="Own">6</categoryId>
<picture>http://magazin.ru/img/tickets14350.jpg</picture>
<delivery>true</delivery>
<local_delivery_cost>300</local_delivery_cost>
<name>
Дмитрий Хворостовский и Национальный филармонический оркестр России. Дирижер — Владимир Спиваков.
</name>
<place>Московский международный Дом музыки</place>
<hall plan="http://magazin.ru/img/mmdm_plan.jpg">Большой зал</hall>
<hall_part>Партер р. 1-5</hall_part>
<date>2009-12-31T19:00</date>
<is_premiere>0</is_premiere>
<is_kids>0</is_kids>
<description>
Концерт Дмитрия Хворостовского и Национального филармонического оркестра России под управлением Владимира Спивакова.
</description>
</offer>
</offers>
</shop>
</yml_catalog>
SAMPLE

