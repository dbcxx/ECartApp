using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ECartApp.Models;
using ECartApp.ViewModel;

namespace ECartApp.Controllers
{
    public class ShoppingController : Controller
    {
        //private classes
        private eCartDbEntities eCartDbEntities;
        private List<cartModel> cartModels;

        //constructors for the above private clases
        public ShoppingController()
        {
            eCartDbEntities = new eCartDbEntities();
            cartModels = new List<cartModel>();
        }
        
        [HttpGet]
        public ActionResult Index()
        {
            IEnumerable<ShoppingViewModel> shoppingViewModels = (from objItem in eCartDbEntities.Items
                                                                 join
                                                                 objCat in eCartDbEntities.Categories
                                                                 on
                                                                 objItem.CategoryId equals objCat.CategoryId
                                                                 select new ShoppingViewModel()
                                                                 {
                                                                     ImagePath = objItem.ImagePath,
                                                                     ItemName = objItem.ItemName,
                                                                     Description = objItem.Description,
                                                                     ItemPrice = objItem.ItemPrice,
                                                                     ItemId = objItem.ItemId,
                                                                     Category = objCat.CategoryName,
                                                                     ItemCode = objItem.ItemCode
                                                                 }).ToList();
            return View(shoppingViewModels);
        }

        [HttpPost]
        public JsonResult Index(string ItemId)
        {
            cartModel cartModel = new cartModel();
           
            Item item = eCartDbEntities.Items.Single(a => a.ItemId.ToString() == ItemId);
            if (Session["cartCounter"] != null)
            {
                cartModels = Session["cartItem"] as List<cartModel>;
            }

            //to check if item is in cart so as to increment quantity or add a new one
            if (cartModels.Any(model => model.ItemId == ItemId)) 
            {
                cartModel = cartModels.Single(model => model.ItemId == ItemId);
                cartModel.Quantity = cartModel.Quantity + 1;
                cartModel.Total = cartModel.Quantity * cartModel.UnitPrice;
            }
            else
            {
                //if it does not exist then we add 
                cartModel.ItemId = ItemId;
                cartModel.ImagePath = item.ImagePath;
                cartModel.ItemName = item.ItemName;
                cartModel.Quantity = 1;
                cartModel.Total = item.ItemPrice;
                cartModel.UnitPrice = item.ItemPrice;
                cartModels.Add(cartModel);
                

            }

            //using session because of the http request once it is not there the list will be empty
            //so with session it will not be empty for that particular session 
            //after adding to cartModels then add to session 
            Session["cartCounter"] = cartModels.Count;
            Session["cartItem"] = cartModels;
            return Json( new { Success= true, Counter = cartModels.Count}, JsonRequestBehavior.AllowGet);
        } 

        public ActionResult CartView()
        {            
                cartModels = Session["cartItem"] as List<cartModel>;
                return View(cartModels);  
        }


        // for saving data to the db 

        [HttpPost]
        public ActionResult AddOrder()
        {
            int OrderId = 0;
            cartModels = Session["cartItem"] as List<cartModel>;
            Order order = new Order()
            {
                OrderDate = DateTime.Now,
                OrderNumber = string.Format("{0:ddmmyyyyHHmmsss}", DateTime.Now)
            };
            eCartDbEntities.Orders.Add(order);
            eCartDbEntities.SaveChanges();
            OrderId = order.OrderId;
            foreach (var item in cartModels)
            {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.Total = item.Total;
                orderDetail.ItemId = item.ItemId;
                orderDetail.OrderId = OrderId;
                orderDetail.Quantity = item.Quantity;
                orderDetail.UnitPrice = item.UnitPrice;
                eCartDbEntities.OrderDetails.Add(orderDetail);
                eCartDbEntities.SaveChanges();
            }
            Session["cartItem"] = null;
            Session["cartCounter"] = null;
            return RedirectToAction("Index");
        }
    }
}