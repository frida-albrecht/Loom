module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-57> : tensor<9x7x7x9xi16>}> : () -> tensor<9x7x7x9xi16>
    %1 = tosa.const_shape  {values = dense<[3, 3, 2, 3]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.tile %0, %1 : (tensor<9x7x7x9xi16>, !tosa.shape<4>) -> tensor<27x21x14x27xi16>
    %3 = tosa.argmax %2 {axis = 2 : i32} : (tensor<27x21x14x27xi16>) -> tensor<27x21x27xi32>
    %4 = tosa.const_shape  {values = dense<[3, 14, 10]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %5 = tosa.const_shape  {values = dense<[12, 7, 5]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.slice %3, %4, %5 : (tensor<27x21x27xi32>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<12x7x5xi32>
    %cast = tensor.cast %6 : tensor<12x7x5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

