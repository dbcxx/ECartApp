using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ECartApp.Models;
using ECartApp.ViewModel;

namespace ECartApp.Controllers
{
    public class ItemController : Controller
    {

        private eCartDbEntities eCartDbEntities;

        //constructor to make use of the private class of  the model 
        public ItemController()
        {
            eCartDbEntities = new eCartDbEntities();
        }

        // GET: Item
        public ActionResult Index()
        {
            ItemViewModel itemViewModel = new ItemViewModel();
            itemViewModel.CategorySelectListItem = (from obj in eCartDbEntities.Categories
                                                    select new SelectListItem()
                                                    {
                                                        Text = obj.CategoryName,
                                                        Value = obj.CategoryId.ToString(),
                                                        Selected = true
                                                    });

            return View(itemViewModel);
        }

        // post 
        [HttpPost]
        public  JsonResult Index(ItemViewModel itemViewModel)
        {  
            //to recover image file extension to check against double image (image name + EXTENSION )
            string Image = Guid.NewGuid() + Path.GetExtension(itemViewModel.ImagePath.FileName); 
            // saving new image to the intended directory 
            itemViewModel.ImagePath.SaveAs(Server.MapPath("~/Images/" + Image));
           // Create an instance to attach properties
            Item item = new Item();
            item.ImagePath = "~/Images/" + Image;
            item.CategoryId = itemViewModel.CategoryId;
            item.Description = itemViewModel.Description;
            item.ItemCode = itemViewModel.ItemCode;
            item.ItemId = Guid.NewGuid();
            item.ItemName = itemViewModel.ItemName;
            item.ItemPrice = itemViewModel.ItemPrice;
            eCartDbEntities.Items.Add(item);
            eCartDbEntities.SaveChanges();
            //troubleshooting point to see teh values from the index formdata make use of the locals and watch tab to view 
            return Json( data: new { Success = true, Message = "Items added "}, JsonRequestBehavior.AllowGet);
        }
    }
}