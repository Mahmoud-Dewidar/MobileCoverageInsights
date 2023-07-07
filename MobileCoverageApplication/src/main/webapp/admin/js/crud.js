// function editUser(id, fname, lname, email, password, balance, phone, role) {
//     $("#edit  input[name='id']").val(id);
//     $("#edit input[name='fname']").val(fname);
//     $("#edit input[name='lname']").val(lname);
//     $("#edit input[name='email']").val(email);
//     $("#edit input[name='password']").val(password);
//     $("#edit  input[name='balance']").val(balance);
//     $("#edit input[name='phone']").val(phone);
//     $("#edit input[name='role']").val(role);
//     console.log(role);
//     $("#edit").modal("show");
//   }

$(document).ready(function () {

    // -------------------------->> EDIT USER FROM DATABASE <<-----------------------------------
    $('#example').on('click', '#edituserbutton', function () {
        // const row = $(this).closest('tr');
        const id = $(this).data("id");
        const fname = $(this).data("fname");
        const lname = $(this).data("lname");
        const email = $(this).data("email");
        const password = $(this).data("password");
        const balance = $(this).data("balance");
        const phone = $(this).data("phone");
        const role = $(this).data("role");
        console.log(id, fname, lname, email, password, balance, phone,role);

        $("#userform input[name='id']").val(id);
        $("#userform input[name='fname']").val(fname);
        $("#userform input[name='lname']").val(lname);
        $("#userform input[name='email']").val(email);
        $("#userform input[name='password']").val(password);
        $("#userform input[name='balance']").val(balance);
        $("#userform input[name='phone']").val(phone);
        $("#userform input[name='role']").val(role);
        $("#edit").modal("show");

        $('#edit').on('click', '#userEditDone', function () {
            $.ajax({
                url: 'UpdateUser.jsp',
                type: 'POST',
                // data: {id: id,fname: fname,lname: lname,email: email,password: password,balance: balance,phone: phone,role: role},
                data: $('#userform').serialize(),
                success: function () {
                    // If the delete was successful, reload the page
                    $('#edit').modal('hide');
                    location.reload();
                },
                error: function () {
                    // If there was an error, display an error message
                    alert('An error occurred while deleting the user.');
                }
            });
        });
    });

    // -------------------------->> EDIT PRODUCT FROM DATABASE <<-----------------------------------
    $('#example').on('click', '#editproductbutton', function () {
        // const row = $(this).closest('tr');
        console.log("Edit Product")
        const id = $(this).data("id");
        const name = $(this).data("name");
        const description = $(this).data("description");
        const price = $(this).data("price");
        const num = $(this).data("num");
        const category = $(this).data("category");
        const review = $(this).data("review");
        console.log(id,name,description,price,num,category);

        $("#productform input[name='id']").val(id);
        $("#productform input[name='name']").val(name);
        $("#productform input[name='description']").val(description);
        $("#productform input[name='price']").val(price);
        $("#productform input[name='pieces']").val(num);
        $("#productform input[name='category']").val(category);
        $("#editProductModal").modal("show");

        $('#editProductModal').on('click', '#productEditDone', function () {
            $.ajax({
                url: 'UpdateProduct.jsp',
                type: 'POST',
                // data: {id: id,name: name,description: description,price: price,num: num,category: category,review: review},
                data: $('#productform').serialize(),
                success: function () {
                    console.log($('#productform').serialize());
                    // If the delete was successful, reload the page
                    $('#editProductModal').modal('hide');
                    location.reload();
                },
                error: function () {
                    // If there was an error, display an error message
                    alert('An Error Occurred While Updating The Product.');
                }
            });
        });
    });


    // -------------------------->> DELETE USER FROM DATABASE <<-----------------------------------
    $('#example').on('click', '#deleteuserbutton', function () {
        const Delete_id = $(this).data('id');
        console.log(Delete_id);

        $('#delete').on('click', '#done', function () {
            $.ajax({
                url: 'DeleteUser.jsp',
                type: 'POST',
                data: {id: Delete_id},
                success: function () {
                    // If the delete was successful, reload the page
                    $('#delete').modal('hide');
                    location.reload();
                },
                error: function () {
                    // If there was an error, display an error message
                    alert('An Error Occurred While Deleting The Product...');
                }
            });
        });
    });


    // -------------------------->> DELETE PRODUCT FROM DATABASE <<-----------------------------------
    $('#example').on('click', '#deleteproductbutton', function () {
        const Delete_id = $(this).data('id');
        console.log(Delete_id);
        console.log("delete product")

        $('#deleteProductModal').on('click', '#deleteProductdone', function () {
            $.ajax({
                url: 'DeleteProduct.jsp',
                type: 'POST',
                data: {id: Delete_id},
                success: function () {
                    // If the delete was successful, reload the page
                    $('#deleteProductModal').modal('hide');
                    location.reload();
                },
                error: function () {
                    // If there was an error, display an error message
                    alert('An error occurred while deleting the user.');
                }
            });
        });
    });
});


    // $('.delete-button').click(function () {
    //     // Get the user's ID from the row
    //     var row = $(this).closest('tr');
    //     var id = row.find('.user-id').text();
    //     // Send a request to the server to delete the user
    //     if (confirm('Are you sure you want to delete this user?')) {
    //         $.ajax({
    //             type: 'POST',
    //             url: 'delete-user.jsp',
    //             data: {id: id},
    //             success: function (response) {
    //                 // Reload the page to show the updated table
    //                 window.location.reload();
    //             },
    //             error: function (xhr, status, error) {
    //                 console.log('Error: ' + error);
    //             }
    //         });
    //     }
    // });

//
//       // Confirm that the user wants to delete the user
//
//   });

// $('#deleteuserbutton').click(function() {
//     // Get the user ID from the button's data attribute
//     const id = $(this).data('id');
//
//     console.log(id);
//     // Confirm that the user wants to delete the user
//     if (confirm('Are you sure you want to delete this user?')) {
//         // Send the user ID to the server using AJAX
//         $.ajax({
//             url: 'DeleteUser.jsp',
//             type: 'POST',
//             data: { id: id },
//             success: function() {
//                 // If the delete was successful, reload the page
//                 location.reload();
//             },
//             error: function() {
//                 // If there was an error, display an error message
//                 alert('An error occurred while deleting the user.');
//             }
//         });
//     }
// });

//     // Set up the click event for the delete button
//     $('#deleteuserbutton').click(function() {
//
//
// });


// $(document).ready(function () {


//   // Handle click event of edit button
//   $("#edituserbutton").click(function () {
//     console.log("Helllllllllllllooo");


//     // Get the user's data from the row
//     // var row = $(this).closest('tr');
//     // var id = row.find('.user-id').text();
//     // var fname = row.find('.user-fname').text();
//     // var lname = row.find('.user-lname').text();
//     // var email = row.find('.user-email').text();
//     // var password = row.find('.user-password').text();
//     // var balance = row.find('.user-balance').text();
//     // var phone = row.find('.user-phone').text();
//     // var role = row.find('.user-role').text();

//     // var row = $(this).closest('tr');
//     // var id = $(this).data("id");
//     // var fname = $(this).data("fname");
//     // var lname = $(this).data("lname");
//     // var email = $(this).data("email");
//     // var password = $(this).data("password");
//     // var balance = $(this).data("balance");
//     // var phone = $(this).data("phone");
//     // var role = $(this).data("role");
//     // console.log(id, fname, lname, email, password, balance, phone);

//     console.log("Helllllllllllllooo");
//     // Populate the form's input fields with the user's data
//     $("#edit #id").val(id);
//     $("#edit #lname").val(lname);
//     $("#edit #email").val(email);
//     $("#edit #password").val(password);
//     $("#edit #balance").val(balance);
//     $("#edit #phone").val(phone);
//     $("#edit #role").val(role);
//     $("#edit #fname").val(fname);
//     // Show the pop-up form
//     $("#edit").modal("show");
//     console.log("Helllllllllllllooo");
//   });

//   // Handle submit event of the edit form
//   $("#userform").submit(function (event) {
//     event.preventDefault();
//     // Send a request to the server to update the user's data
//     $.ajax({
//       type: "POST",
//       url: "UpdateUser.jsp",
//       data: $(this).serialize(),
//       success: function (response) {
//         // Reload the page to show the updated table
//         console.log("Helllllllllllllooo Reload");
//         window.location.reload();
//       },
//       error: function (xhr, status, error) {
//         console.log("Error: " + error);
//       },
//     });
//   });
// });
