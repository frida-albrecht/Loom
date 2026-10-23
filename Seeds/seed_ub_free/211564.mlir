module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<10x6x8x3xi1>}> : () -> tensor<10x6x8x3xi1>
    %1 = "tosa.const"() <{values = dense<4.262000e+01> : tensor<7x2xf32>}> : () -> tensor<7x2xf32>
    %2 = tosa.argmax %0 {axis = 2 : i32} : (tensor<10x6x8x3xi1>) -> tensor<10x6x3xi32>
    %3 = tosa.const_shape  {values = dense<[3, 2, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %4 = tosa.tile %2, %3 : (tensor<10x6x3xi32>, !tosa.shape<3>) -> tensor<30x12x6xi32>
    %5 = tosa.log %1 : (tensor<7x2xf32>) -> tensor<7x2xf32>
    %6 = tosa.identity %4 : (tensor<30x12x6xi32>) -> tensor<30x12x6xi32>
    %cast = tensor.cast %5 : tensor<7x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<30x12x6xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

