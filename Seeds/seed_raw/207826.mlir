module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<1x6xi1>}> : () -> tensor<1x6xi1>
    %1 = "tosa.const"() <{values = dense<-4.832000e+01> : tensor<5x8x2xf32>}> : () -> tensor<5x8x2xf32>
    %2 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<1x6xi1>) -> tensor<1x6xi1>
    %3 = tosa.reduce_any %2 {axis = 0 : i32} : (tensor<1x6xi1>) -> tensor<1x6xi1>
    %4 = tosa.const_shape  {values = dense<[3, 2]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %5 = tosa.tile %3, %4 : (tensor<1x6xi1>, !tosa.shape<2>) -> tensor<3x12xi1>
    %6 = tosa.reduce_product %5 {axis = 1 : i32} : (tensor<3x12xi1>) -> tensor<3x1xi1>
    %7 = tosa.reciprocal %1 : (tensor<5x8x2xf32>) -> tensor<5x8x2xf32>
    %8 = tosa.argmax %6 {axis = 0 : i32} : (tensor<3x1xi1>) -> tensor<1xi32>
    %9 = tosa.pow %7, %7 : (tensor<5x8x2xf32>, tensor<5x8x2xf32>) -> tensor<5x8x2xf32>
    %10 = tosa.reduce_product %7 {axis = 2 : i32} : (tensor<5x8x2xf32>) -> tensor<5x8x1xf32>
    %cast = tensor.cast %8 : tensor<1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %9 : tensor<5x8x2xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %10 : tensor<5x8x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

