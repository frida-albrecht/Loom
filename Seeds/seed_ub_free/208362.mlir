module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-54> : tensor<1x6x7xi32>}> : () -> tensor<1x6x7xi32>
    %1 = "tosa.const"() <{values = dense<22> : tensor<1x7x7xi32>}> : () -> tensor<1x7x7xi32>
    %2 = "tosa.const"() <{values = dense<-2.000000e+00> : tensor<1x9xf32>}> : () -> tensor<1x9xf32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = tosa.matmul %0, %1, %3, %4 : (tensor<1x6x7xi32>, tensor<1x7x7xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<1x6x7xi32>
    %6 = tosa.minimum %5, %5 : (tensor<1x6x7xi32>, tensor<1x6x7xi32>) -> tensor<1x6x7xi32>
    %7 = tosa.rsqrt %2 : (tensor<1x9xf32>) -> tensor<1x9xf32>
    %8 = tosa.reduce_product %6 {axis = 2 : i32} : (tensor<1x6x7xi32>) -> tensor<1x6x1xi32>
    %f1 = "tosa.const"() <{values = dense<1.000000e+00> : tensor<1x9xf32>}> : () -> tensor<1x9xf32>
    %9 = tosa.pow %f1, %f1 : (tensor<1x9xf32>, tensor<1x9xf32>) -> tensor<1x9xf32>
    %10 = tosa.bitwise_not %5 : (tensor<1x6x7xi32>) -> tensor<1x6x7xi32>
    %11 = tosa.reduce_max %7 {axis = 0 : i32} : (tensor<1x9xf32>) -> tensor<1x9xf32>
    %cast = tensor.cast %8 : tensor<1x6x1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<1x9xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<1x6x7xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %11 : tensor<1x9xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}