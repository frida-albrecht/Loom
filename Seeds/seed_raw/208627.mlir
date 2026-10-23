module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<false> : tensor<10x5xi1>}> : () -> tensor<10x5xi1>
    %1 = "tosa.const"() <{values = dense<1.697700e+02> : tensor<8x4xf32>}> : () -> tensor<8x4xf32>
    %2 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<10x5xi1>) -> tensor<1x5xi1>
    %3 = tosa.argmax %2 {axis = 1 : i32} : (tensor<1x5xi1>) -> tensor<1xi32>
    %4 = tosa.floor %1 : (tensor<8x4xf32>) -> tensor<8x4xf32>
    %5 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<8x4xf32>) -> tensor<1x4xf32>
    %6 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.tile %5, %6 : (tensor<1x4xf32>, !tosa.shape<2>) -> tensor<1x4xf32>
    %8 = tosa.reverse %3 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %7 : tensor<1x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

