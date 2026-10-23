module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-92> : tensor<5xi32>}> : () -> tensor<5xi32>
    %1 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.tile %0, %1 : (tensor<5xi32>, !tosa.shape<1>) -> tensor<15xi32>
    %cast = tensor.cast %2 : tensor<15xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

