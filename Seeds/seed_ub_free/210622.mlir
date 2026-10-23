module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.115800e+02> : tensor<1x5x1xf32>}> : () -> tensor<1x5x1xf32>
    %1 = "tosa.const"() <{values = dense<7.523000e+01> : tensor<1x1x1xf32>}> : () -> tensor<1x1x1xf32>
    %c1 = "tosa.const"() <{values = dense<0.0> : tensor<1x5x1xf32>}> : () -> tensor<1x5x1xf32>
    %a1 = tosa.maximum %0, %c1 : (tensor<1x5x1xf32>, tensor<1x5x1xf32>) -> tensor<1x5x1xf32>
    %2 = "tosa.const"() <{values = dense<181> : tensor<2x6xi32>}> : () -> tensor<2x6xi32>
    %3 = tosa.pow %a1, %1 : (tensor<1x5x1xf32>, tensor<1x1x1xf32>) -> tensor<1x5x1xf32>
    %4 = tosa.clz %2 : (tensor<2x6xi32>) -> tensor<2x6xi32>
    %5 = tosa.reduce_sum %4 {axis = 0 : i32} : (tensor<2x6xi32>) -> tensor<1x6xi32>
    %6 = tosa.const_shape  {values = dense<[5, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.reshape %3, %6 : (tensor<1x5x1xf32>, !tosa.shape<2>) -> tensor<5x1xf32>
    %c2 = "tosa.const"() <{values = dense<0> : tensor<1x6xi32>}> : () -> tensor<1x6xi32>
    %c3 = "tosa.const"() <{values = dense<31> : tensor<1x6xi32>}> : () -> tensor<1x6xi32>
    %a2 = tosa.maximum %5, %c2 : (tensor<1x6xi32>, tensor<1x6xi32>) -> tensor<1x6xi32>
    %a3 = tosa.minimum %a2, %c3 : (tensor<1x6xi32>, tensor<1x6xi32>) -> tensor<1x6xi32>
    %8 = tosa.logical_right_shift %5, %a3 : (tensor<1x6xi32>, tensor<1x6xi32>) -> tensor<1x6xi32>
    %9 = tosa.reduce_sum %5 {axis = 0 : i32} : (tensor<1x6xi32>) -> tensor<1x6xi32>
    %10 = tosa.reciprocal %7 : (tensor<5x1xf32>) -> tensor<5x1xf32>
    %cast = tensor.cast %8 : tensor<1x6xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<1x6xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %10 : tensor<5x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}