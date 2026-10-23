module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<123> : tensor<4x9xi32>}> : () -> tensor<4x9xi32>
    %1 = "tosa.const"() <{values = dense<-2> : tensor<4x9xi32>}> : () -> tensor<4x9xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<4x9xi32>, tensor<4x9xi32>) -> tensor<4x9xi32>
    %3 = tosa.const_shape  {values = dense<3> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = tosa.tile %2, %3 : (tensor<4x9xi32>, !tosa.shape<2>) -> tensor<12x27xi32>
    %cast = tensor.cast %4 : tensor<12x27xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

