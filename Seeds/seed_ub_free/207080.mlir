module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<27> : tensor<6x10x8xi16>}> : () -> tensor<6x10x8xi16>
    %1 = "tosa.const"() <{values = dense<-87> : tensor<3x2xi32>}> : () -> tensor<3x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<6xindex>} : () -> !tosa.shape<6>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %4 = tosa.pad %0, %2, %3 : (tensor<6x10x8xi16>, !tosa.shape<6>, tensor<1xi16>) -> tensor<6x10x8xi16>
    %5 = tosa.argmax %4 {axis = 1 : i32} : (tensor<6x10x8xi16>) -> tensor<6x8xi32>
    %cast = tensor.cast %5 : tensor<6x8xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

