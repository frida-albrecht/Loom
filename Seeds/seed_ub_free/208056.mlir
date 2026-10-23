module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-136> : tensor<7x3xi32>}> : () -> tensor<7x3xi32>
    %1 = "tosa.const"() <{values = dense<-76.1399993> : tensor<8x9x4xf32>}> : () -> tensor<8x9x4xf32>
    %2 = tosa.const_shape  {values = dense<[3, 1]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %3 = tosa.tile %0, %2 : (tensor<7x3xi32>, !tosa.shape<2>) -> tensor<21x3xi32>
    %4 = tosa.tanh %1 : (tensor<8x9x4xf32>) -> tensor<8x9x4xf32>
    %5 = tosa.reduce_product %3 {axis = 1 : i32} : (tensor<21x3xi32>) -> tensor<21x1xi32>
    %cast = tensor.cast %4 : tensor<8x9x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<21x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

