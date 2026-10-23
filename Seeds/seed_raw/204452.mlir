module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<2x2x6x5xi8>}> : () -> tensor<2x2x6x5xi8>
    %1 = "tosa.const"() <{values = dense<-19> : tensor<1x1x6x1xi8>}> : () -> tensor<1x1x6x1xi8>
    %2 = tosa.sub %0, %1 : (tensor<2x2x6x5xi8>, tensor<1x1x6x1xi8>) -> tensor<2x2x6x5xi8>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<2x2x6x5xi8>) -> tensor<2x6x5xi32>
    %4 = tosa.const_shape  {values = dense<[3, 3, 1]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.tile %3, %4 : (tensor<2x6x5xi32>, !tosa.shape<3>) -> tensor<6x18x5xi32>
    %cast = tensor.cast %5 : tensor<6x18x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

