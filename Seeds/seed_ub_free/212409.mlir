module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.280000e+01> : tensor<8x2xf32>}> : () -> tensor<8x2xf32>
    %1 = tosa.abs %0 : (tensor<8x2xf32>) -> tensor<8x2xf32>
    %2 = tosa.const_shape  {values = dense<2> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.tile %1, %2 : (tensor<8x2xf32>, !tosa.shape<2>) -> tensor<16x4xf32>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<16x4xf32>) -> tensor<4xi32>
    %5 = tosa.tanh %3 : (tensor<16x4xf32>) -> tensor<16x4xf32>
    %cast = tensor.cast %4 : tensor<4xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<16x4xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

