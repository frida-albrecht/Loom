module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<56> : tensor<7x2x4xi16>}> : () -> tensor<7x2x4xi16>
    %1 = "tosa.const"() <{values = dense<-25> : tensor<7x98x4xi16>}> : () -> tensor<7x98x4xi16>
    %2 = "tosa.const"() <{values = dense<92.8899993> : tensor<3xf32>}> : () -> tensor<3xf32>
    %3 = tosa.concat %0, %1 {axis = 1 : i32} : (tensor<7x2x4xi16>, tensor<7x98x4xi16>) -> tensor<7x100x4xi16>
    %4 = tosa.ceil %2 : (tensor<3xf32>) -> tensor<3xf32>
    %5 = tosa.maximum %4, %4 : (tensor<3xf32>, tensor<3xf32>) -> tensor<3xf32>
    %cast = tensor.cast %3 : tensor<7x100x4xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<3xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

