module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.684000e+01> : tensor<8x3xf32>}> : () -> tensor<8x3xf32>
    %1 = "tosa.const"() <{values = dense<-69> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-99> : tensor<i32>}> : () -> tensor<i32>
    %3 = tosa.log %0 : (tensor<8x3xf32>) -> tensor<8x3xf32>
    %4 = tosa.reduce_max %3 {axis = 1 : i32} : (tensor<8x3xf32>) -> tensor<8x1xf32>
    %5 = tosa.intdiv %1, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %6 = tosa.const_shape  {values = dense<[1, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.tile %4, %6 : (tensor<8x1xf32>, !tosa.shape<2>) -> tensor<8x2xf32>
    %8 = tosa.reduce_sum %7 {axis = 1 : i32} : (tensor<8x2xf32>) -> tensor<8x1xf32>
    %9 = tosa.add %5, %5 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %10 = tosa.reduce_max %8 {axis = 1 : i32} : (tensor<8x1xf32>) -> tensor<8x1xf32>
    %cast = tensor.cast %9 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<8x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

