module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<59> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = "tosa.const"() <{values = dense<-1.636600e+02> : tensor<2x6x2x6xf32>}> : () -> tensor<2x6x2x6xf32>
    %2 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.tile %0, %2 : (tensor<4xi32>, !tosa.shape<1>) -> tensor<4xi32>
    %4 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.tile %3, %4 : (tensor<4xi32>, !tosa.shape<1>) -> tensor<4xi32>
    %6 = tosa.tanh %1 : (tensor<2x6x2x6xf32>) -> tensor<2x6x2x6xf32>
    %7 = tosa.clz %5 : (tensor<4xi32>) -> tensor<4xi32>
    %8 = tosa.reverse %7 {axis = 0 : i32} : (tensor<4xi32>) -> tensor<4xi32>
    %cast = tensor.cast %6 : tensor<2x6x2x6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<4xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

